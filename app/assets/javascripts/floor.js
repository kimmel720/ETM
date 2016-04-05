


function init() {

        var scene = new THREE.Scene();

        var floorUrl = $('.exhibition_class').data('exhibition');

        // create a camera, which defines where we're looking at. 16 is optimal
        var camera = new THREE.PerspectiveCamera(16, window.innerWidth / window.innerHeight, 0.1, 1000);

        // create a render and set the size
        var webGLRenderer = new THREE.WebGLRenderer();
        webGLRenderer.setClearColor(new THREE.Color(0xffffff, 1.0));
        webGLRenderer.setSize(window.innerWidth/1.4, window.innerHeight/1.4);
        webGLRenderer.shadowMapEnabled = true;

        //0, 0, 5 for camera in the middle
        camera.position.x = 0;
        camera.position.y = 130;
        camera.position.z = 0;
        camera.lookAt(new THREE.Vector3(0, 0, 0 ));


        var spotLight = new THREE.SpotLight(0xffffff);
        spotLight.position.set(0, 150, 0);
        spotLight.intensity = 0.25;
        scene.add(spotLight);

        var ambiLight = new THREE.AmbientLight(0xd7d2b5);
        scene.add(ambiLight);



        // add the output of the renderer to the html element
        document.getElementById("WebGL-output").appendChild(webGLRenderer.domElement);


        var box = createMesh(new THREE.BoxGeometry(44.7, 3, 32.5), floorUrl);

        box.position.x = 0;
        box.position.y = 0;
        box.position.z = 0;
        box.rotateY(3.14/2);

        scene.add(box);

        function createMesh(geom, imageFile) {
           var texture = THREE.ImageUtils.loadTexture(imageFile);
           var mat = new THREE.MeshPhongMaterial();
           mat.map = texture;
           mat.side = THREE.DoubleSide;
           var mesh = new THREE.Mesh(geom, mat);
           return mesh;
        }

      //  var boxMaterial = new THREE.MeshBasicMaterial({color: 0x000000});
      //  var box1 = new THREE.Mesh(new THREE.BoxGeometry(0.5, 5, 1), boxMaterial);
      //  box1.position.x = 7.45;
      //  scene.add(box1);

         var boxMaterial = new THREE.MeshLambertMaterial({color: 0x0f24b0, transparent: true, opacity: 0.5});
         var box2 = new THREE.Mesh(new THREE.BoxGeometry(20, 5, 8), boxMaterial);
         box2.position.x = -0.70;
         box2.position.z = 0.30;
         box2.userData = { URL: 'https://www.yahoo.com/'};
         scene.add(box2);

         var box3 = new THREE.Mesh(new THREE.BoxGeometry(3.2, 5, 0.8), boxMaterial);
         box3.position.x = -10.95;
         box3.position.z = -20.85;
         box3.userData = { URL: 'https://www.google.com/'};
         scene.add(box3);


         render();


         function render() {
            requestAnimationFrame(render);
            webGLRenderer.render(scene, camera);
         }

         function onDocumentMouseDown(event) {

   					var vector = new THREE.Vector3(( event.clientX / window.innerWidth ) * 2 - 1, -( event.clientY / window.innerHeight ) * 2 + 1, 0.5);
   					vector = vector.unproject(camera);

   					var raycaster = new THREE.Raycaster(camera.position, vector.sub(camera.position).normalize());

   					var intersects = raycaster.intersectObjects(scene.children);

   					if (intersects.length > 2) {

              if (intersects[0] != box) {

                console.log(intersects[0].object.userData);

                window.open(intersects[0].object.userData.URL);
              }




   					}
   			}

        document.addEventListener('mousedown', onDocumentMouseDown, false);
    }
    window.onload = init;
