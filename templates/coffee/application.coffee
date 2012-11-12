camera = undefined
scene = undefined
renderer = undefined
geometry = undefined
material = undefined
parent = undefined

init = (css)->
  console.log  css
  camera = new THREE.PerspectiveCamera 75, window.innerWidth / window.innerHeight, 1, 10000
  camera.position.z = 1000
  scene = new THREE.Scene()
  parent = new THREE.Object3D()
  parent.position.y = 50
  scene.add( parent )
  
  geometry = new THREE.CubeGeometry 511, 511, 511
  material = new THREE.MeshBasicMaterial
    side: THREE.DoubleSide
    color: 0
    wireframe: true
  mesh = new THREE.Mesh geometry, material
  parent.add mesh

  for color in css.match /(#[\da-fA-F]{6}|#[\da-fA-F]{3}|rgba?\((\s*[\d\.]+\s*,?){3,4}\))/g


    console.log color
    color = $.xcolor.test color

    dotGeometry = new THREE.SphereGeometry 4
    dotMaterial = new THREE.MeshBasicMaterial
      color: color.getInt()
    dotMesh = new THREE.Mesh dotGeometry, dotMaterial
    dotMesh.position.x = 255 - color.r * 2
    dotMesh.position.y = 255 - color.g * 2
    dotMesh.position.z = 255 - color.b * 2
    parent.add dotMesh

  renderer = new THREE.CanvasRenderer()
  renderer.setSize window.innerWidth, window.innerHeight
  document.body.appendChild renderer.domElement

animate = ->
  # note: three.js includes requestAnimationFrame shim
  requestAnimationFrame animate
  parent.rotation.x += 0.01
  parent.rotation.y += 0.02
  renderer.render scene, camera


$ ->
  $('form').on 'submit', (e)->
    e.preventDefault()
    init $('textarea').val()
    animate()

