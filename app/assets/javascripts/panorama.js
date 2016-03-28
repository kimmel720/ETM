    function init() {

        var scene = new THREE.Scene();

        // create a camera, which defines where we're looking at. 16 is optimal
        var camera = new THREE.PerspectiveCamera(46.6, window.innerWidth / window.innerHeight, 0.1, 1000);

        // create a render and set the size
        var webGLRenderer = new THREE.WebGLRenderer();
        webGLRenderer.setClearColor(new THREE.Color(0xcccccc, 1.0));
        webGLRenderer.setSize(window.innerWidth, window.innerHeight);
        webGLRenderer.shadowMapEnabled = true;

        var axisHelper = new THREE.AxisHelper( 60 );
        scene.add( axisHelper );

        //0, 0, 5 for camera in the middle
        camera.position.x = 0;
        camera.position.y = 0;
        camera.position.z = 0;
        camera.lookAt(new THREE.Vector3(0, 0, 0 ));

        var projector = new THREE.Projector();

        var spotLight = new THREE.SpotLight(0xffffff);
        spotLight.position.set(0, 150, 0);
        spotLight.intensity = 1;
        scene.add(spotLight);

        var ambiLight = new THREE.AmbientLight(0xd7d2b5);
        scene.add(ambiLight);



        // add the output of the renderer to the html element
        document.getElementById("WebGL-output").appendChild(webGLRenderer.domElement);

        var cylinder = createMesh(new THREE.CylinderGeometry(70, 70, 60, 30, 8, true));

        cylinder.position.x = 0;
        cylinder.position.y = 0;
        cylinder.position.z = 0;
        cylinder.rotateY(3.14/2);

        scene.add(cylinder);

        var geometry = new THREE.BoxGeometry( 5, 10, 10 );
        var material = new THREE.MeshLambertMaterial({color: 0x0000ff, transparent: true, opacity: 0.2});
        var cube = new THREE.Mesh( geometry, material );
        cube.position.z = -70;
        cube.position.x = 4;
        scene.add( cube );


        var cubeTwo = new THREE.Mesh( geometry, material );
        cubeTwo.position.z = -70;
        cubeTwo.position.x = 15;
        scene.add( cubeTwo );

        function createMesh(geom) {
           var texture = THREE.ImageUtils.loadTexture('http://people.brandeis.edu/~ddimitr/Images/panoramaTexture.jpg');
           var mat = new THREE.MeshPhongMaterial();
           mat.map = texture;
           mat.side = THREE.DoubleSide;
           var mesh = new THREE.Mesh(geom, mat);
           return mesh;
       }


        var turningRight = false;
        var turningLeft = false;

        render();


        function render() {
            requestAnimationFrame(render);
            updateCameraObject();
            webGLRenderer.render(scene, camera);
        }

        function onDocumentMouseDown(event) {

            var vector = new THREE.Vector3(( event.clientX / window.innerWidth ) * 2 - 1, -( event.clientY / window.innerHeight ) * 2 + 1, 0.5);
            vector = vector.unproject(camera);

            var raycaster = new THREE.Raycaster(camera.position, vector.sub(camera.position).normalize());

            var intersects = raycaster.intersectObjects([cube, cubeTwo]);

            if (intersects.length > 0) {

                console.log(intersects[0]);

                window.open('http://www.google.com');

                //window.location.href = 'http://www.google.com';

            }
        }

        function onDocumentMouseMove(event) {

            var vector = new THREE.Vector3(( event.clientX / window.innerWidth ) * 2 - 1, -( event.clientY / window.innerHeight ) * 2 + 1, 0.5);
            vector = vector.unproject(camera);

            var raycaster = new THREE.Raycaster(camera.position, vector.sub(camera.position).normalize());

            var intersects = raycaster.intersectObjects([cube, cubeTwo]);

            if (intersects.length > 0) {

                console.log(intersects[0]);

                intersects[0].object.material.transparent = true;
                intersects[0].object.material.opacity = 0.5;
            }

            setTimeout(revert, 3000);

        }

        function revert() {
            material.opacity = 0;
        }



        function updateCameraObject(){
          if (turningRight) {
            camera.rotateY(-0.007);
          } else if (turningLeft){
            camera.rotateY(0.007);
          }


        }

        function turnRight(event) {
            if (event.keyCode === 39) { //right arrow key
            turningRight = true;

            }
        }

        function turnLeft(event) {
            if (event.keyCode === 37) { //left arrow key
            turningLeft=true;
            }
        }

        function stop(event){
          turningRight = false;
          turningLeft = false;
        }

        function onWindowResize() {
				      camera.aspect = window.innerWidth / window.innerHeight;
				      camera.updateProjectionMatrix();
				      webGLRenderer.setSize( window.innerWidth, window.innerHeight );
			   }

        document.addEventListener('keydown', turnRight, false);
        document.addEventListener('keydown', turnLeft, false);
        document.addEventListener('keyup', stop, false);
        document.addEventListener('mousedown', onDocumentMouseDown, false);
        document.addEventListener('mousemove', onDocumentMouseMove, false);
        window.addEventListener( 'resize', onWindowResize, false );


    }
    window.onload = init;
