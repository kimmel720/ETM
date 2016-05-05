$(".panoramas.show").ready(init);

function init() {
	var container, renderer, raycaster; // element containing canvas
	var cylinder; // cylinder mesh for panorama
	var camera, scene; // scene
	var mouse = new THREE.Vector2(),
	    INTERSECTED;
	var radius = 100,
	    theta = 0;
	var panoramUrl;
	var preimage = null;

	CANVAS_WIDTH = 1400,
	CANVAS_HEIGHT = 600;

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

	function createMeshSphr(geom) {
      // assign two materials
      var meshMaterial = new THREE.MeshLambertMaterial({color: 0xe4e5f1, transparent:true, opacity: 0.3});
      var wireFrameMat = new THREE.MeshLambertMaterial({color: 0xe4e5f1, transparent:true, opacity: 0.3});
      // create a multimaterial
      var mesh = THREE.SceneUtils.createMultiMaterialObject(geom, [meshMaterial, wireFrameMat]);
      return mesh;
  }

	function drawBoxes(boxArray, type) {
			for (var id in boxArray) {
				var box = boxArray[id];

				var sphere = createMeshSphr(new THREE.SphereGeometry(box[3], 30, 30));

				sphere.position.x = box[0];
				sphere.position.y = box[1];
				sphere.position.z = box[2];
				scene.add(sphere);

				sphere.userData = {
						URL: box[4],
						type: type
				};
				scene.add(sphere);
			}

	}

	function loadPanorama() {
			drawPanorama(gon.image);
	    drawBoxes(gon.art_array, "art");
	    drawBoxes(gon.pan_array, "pan");
	}

	function loadNewPanorama() {

	}

	function transition(newPanoramaUrl) {
		console.log(newPanoramaUrl);
	    $.ajax({
	        url: newPanoramaUrl,
	        type: "GET",
	    }).success( function(result) {
				console.log(result);
				update(result.image, result.art_array, result.pan_array);
			});
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
	        mouse.y = -((event.clientY-200) / CANVAS_HEIGHT) * 2 + 1;
	    }

	    function onDocumentMouseDown(event) {
	        var vector = new THREE.Vector3((event.clientX / CANVAS_WIDTH) * 2 - 1, -((event.clientY-200) / CANVAS_HEIGHT) * 2 + 1, 0.5);
	        vector = vector.unproject(camera);

	        var raycaster = new THREE.Raycaster(camera.position, vector.sub(camera.position).normalize());

	        var intersects = raycaster.intersectObjects(scene.children, true);

	        if (intersects.length > 1) {
							var box = intersects[0].object.parent;
							if (box.userData.type == "art") {
								window.open(box.userData.URL);
							} else if (box.userData.type == "pan") {
								transition(box.userData.URL);
							}
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
	    var intersects = raycaster.intersectObjects(scene.children, true);
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
    animate();
}
