$(".panoramas.edit").ready(initEdit);


// TODO: fix namespace conflict between panorama.js and edit_panorama.js, realistically
// these should be in the same file
function initEdit() {
  var container, renderer, raycaster; // element containing canvas
  var cylinder; // cylinder mesh for panorama
  var camera, scene; // scene
  var mouse = new THREE.Vector2(),
      INTERSECTED;
  var radius = 100,
      theta = 0;
  var panoramUrl;
  var preimage = null;

  var controls, gui;
  var array = [];
  var curSphere;

  var add = true;

  CANVAS_WIDTH = 1400,
  CANVAS_HEIGHT = 600;

  function buildArtworkList(){
    none = {'NONE': -1};
    artworks = JSON.parse(gon.artworks);
    return $.extend({}, none, artworks);
  }

  function buildAdjacencyList() {
    none = {'NONE': -1};
    adjacencies = JSON.parse(gon.panoramas);
    return $.extend({}, none, adjacencies);
  }

  function loadControls() {
    controls = new function () {
        // we need the first child, since it's a multimaterial
        this.radius = 5;
        this.artwork = -1;
        this.adjacency = -1;

        this.save = function () {
          var art = {
            x: sphere.position.x,
            y: sphere.position.y,
            z: sphere.position.z,
            r: controls.radius
          };



          if (this.artwork != -1){
            add_url = "http://localhost:3000/panoramas/" + gon.id + "/add_art/" + this.artwork;
            console.log("add_url: " + add_url);

            console.log(art);
            $.ajax({
      	        url: add_url,
      	        type: "POST",
                dataType: "JSON",
                data: art
      	    });
          } else if (this.adjacency != -1) {
            add_url = "http://localhost:3000/panoramas/" + gon.id + "/add_pan/" + this.adjacency;
            console.log("add_url: " + add_url);

            console.log(art);
            $.ajax({
      	        url: add_url,
      	        type: "POST",
                dataType: "JSON",
                data: art
      	    });
          }
          add = true;
          $('.dg.main').remove();
        };
        this.cancel = function(){
          $('.dg.main').remove();
          scene.remove(curSphere);
          add = true;
        };
        this.redraw = function () {
            // remove the old plane
            var posX = sphere.position.x;
            var posY = sphere.position.y;
            var posZ = sphere.position.z;
            scene.remove(sphere);
            // create a new one
            sphere = createMeshSphr(new THREE.SphereGeometry(controls.radius, 30, 30));
            // add it to the scene.
            sphere.position.x = posX;
            sphere.position.y = posY;
            sphere.position.z = posZ;
            scene.add(sphere);
        };
    };


  }

  function loadEnvironment() {
      container = $('#panoramaContainer');
      renderer = new THREE.WebGLRenderer();
      raycaster = new THREE.Raycaster();
      renderer.setClearColor(0xf0f0f0);
      renderer.setSize(CANVAS_WIDTH, CANVAS_HEIGHT);
      renderer.sortObjects = false;
      container.append(renderer.domElement);
  }

  function loadScene() {
    // set up the scene
    scene = new THREE.Scene();

    camera = new THREE.PerspectiveCamera(46.6, CANVAS_WIDTH / CANVAS_HEIGHT, 0.1, 1000);
    camera.position.set(0, 0, 0);
    camera.lookAt(new THREE.Vector3(0, 0, 0));

    var spotlight = new THREE.SpotLight(0xffffff);
    spotlight.position.set(0, 150, 0);
    spotlight.intensity = 1;
    scene.add(spotlight);

    scene.add(new THREE.AmbientLight(0xf4f5ec));
  }

  function drawPanorama(image) {
    cylinder = createMesh(new THREE.CylinderGeometry(70, 70, 70, 30, 8, true), image);
    cylinder.position.set(0, 0, 0);

    cylinder.rotateY(3.14 / 2);
    scene.add(cylinder);
  }

  function updatePanorama(image) {
  	cylinder = createMesh(new THREE.CylinderGeometry(70, 70, 70, 30, 8, true), image);
  	cylinder.position.set(0, 0, 0);
  	cylinder.rotateY(3.14 / 2);
  	cylinder.needsUpdate = true;
  }

  function loadPanorama() {
      var image = gon.image;
  		drawPanorama(image);
  }

  function update(newTexture, newArt, newPan) {
  		// leave the first 3 children, which are lights and the cylinder, untouched
  		for (var i = scene.children.length-1; i >= 3; i--) {
  			scene.remove(scene.children[i]);
  		}
      cylinder.material.map = new THREE.TextureLoader().load( newTexture );
      cylinder.material.needsUpdate = true;

  		drawBoxes(newArt, "art");
  		drawBoxes(newPan, "pan");
  }

  function saveData() {
      array.push([sphere.position.z, sphere.position.x, sphere.position.y, sphere.radius ]);
  }

  function createMeshSphr(geom) {
      // assign two materials
      var meshMaterial = new THREE.MeshLambertMaterial({color: 0xe4e5f1, transparent:true, opacity: 0.3});
      var wireFrameMat = new THREE.MeshLambertMaterial({color: 0xe4e5f1, transparent:true, opacity: 0.3});
      // create a multimaterial
      var mesh = THREE.SceneUtils.createMultiMaterialObject(geom, [meshMaterial, wireFrameMat]);
      return mesh;
  }

  function createMesh(geom, imageFile) {
      var texture = new THREE.TextureLoader().load(imageFile);
      var mat = new THREE.MeshPhongMaterial();
      mat.map = texture;
      mat.side = THREE.DoubleSide;

      var mesh = new THREE.Mesh(geom, mat);

      return mesh;
  }

  function loadListeners() {
      $('canvas').on('mousemove', onDocumentMouseMove);
      $('canvas').on('mousedown', onDocumentMouseDown);
      window.addEventListener('resize', onWindowResize, false);
      document.addEventListener('keydown', turnRight, false);
      document.addEventListener('keydown', turnLeft, false);
      document.addEventListener('keyup', stop, false);

      function onWindowResize() {
          camera.aspect = CANVAS_WIDTH / CANVAS_HEIGHT;
          camera.updateProjectionMatrix();
          renderer.setSize(CANVAS_WIDTH, CANVAS_HEIGHT);
      }

      function onDocumentMouseMove(event) {
          event.preventDefault();
          mouse.x = (event.clientX / CANVAS_WIDTH) * 2 - 1;
          mouse.y = -((event.clientY-120) / CANVAS_HEIGHT) * 2 + 1;
      }

      function onDocumentMouseDown(event) {
        if (add) {
            add = false;
            gui = new dat.GUI();
            gui.add(controls, 'radius', 0, 40).onChange(controls.redraw);
            gui.add(controls, 'save');
            artworkSelectControl = gui.add(controls, 'artwork', buildArtworkList());
            artworkSelectControl.name('Artwork');
            panoramaSelectControl = gui.add(controls, 'adjacency', buildAdjacencyList());
            panoramaSelectControl.name('Panoramas');
            gui.add(controls, 'cancel');
          var vector = new THREE.Vector3((event.clientX / CANVAS_WIDTH) * 2 - 1, -((event.clientY -120) / CANVAS_HEIGHT) * 2 + 1, 0.5);
            var raycaster = new THREE.Raycaster();
            raycaster.setFromCamera( vector, camera );
            var intersects = raycaster.intersectObjects(scene.children);
            sphere = createMeshSphr(new THREE.SphereGeometry(5, 30, 30));
            sphere.position.z = intersects[0].point.z;
            sphere.position.x = intersects[0].point.x;
            sphere.position.y = intersects[0].point.y;
            scene.add( sphere );
            curSphere = sphere;
            console.log(scene.children);
        }
      }



      function turnRight(event) {
          if (event.keyCode === 39) { //right arrow key
              turningRight = true;
          }
      }

      function turnLeft(event) {
          if (event.keyCode === 37) { //left arrow key
              turningLeft = true;
          }
      }

      function stop(event) {
          turningRight = false;
          turningLeft = false;
      }
  }

  function animate() {
      requestAnimationFrame(animate);
      render();
  }

  var turningRight = false;
  var turningLeft = false;
  function updateCameraObject() {
      if (turningRight) {
          camera.rotateY(-0.007);
      } else if (turningLeft) {
          camera.rotateY(0.007);
      }
  }

  function render() {
      updateCameraObject();
      camera.updateMatrixWorld();
      // find intersections
      raycaster.setFromCamera(mouse, camera);
      var intersects = raycaster.intersectObjects(scene.children);
      if (intersects.length > 0) {
          if (INTERSECTED != intersects[0].object) {

              if (INTERSECTED) INTERSECTED.material.opacity = 0;

              INTERSECTED = intersects[0].object;
              INTERSECTED.material.opacity = 0.4;

          }
      } else {

          if (INTERSECTED) INTERSECTED.material.opacity = 0;

          INTERSECTED = null;

      }
      renderer.render(scene, camera);
  }

    loadEnvironment();
    loadScene();
    loadPanorama();
    loadListeners();
    loadControls();
    animate();
}
