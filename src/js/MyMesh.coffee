Param  = require('./core/Param')
Conf   = require('./core/Conf')
Tween  = require('./core/Tween')
Util   = require('./libs/Util')
Update = require('./libs/Update')


class MyMesh extends THREE.Mesh


  constructor: (opt) ->

    super(
      new THREE.SphereBufferGeometry(0.5, 32, 32),
      # new THREE.BoxBufferGeometry(1, 1, 1),
      new THREE.MeshPhongMaterial({
        color: 0xff0000
        emissive: 0x000000
        # specular: 0x0000ff
        flatShading: false
        overdraw: 1
        shininess: 0
      })
    )

    @param = {
      id:opt.meshId
      scale:0
      position:new THREE.Vector3()
      aroundSpeed:0
      radius:0
      speed:0
      angle:0
      isNoise:false
      isSmall:false
    }




  # -----------------------------------------------
  #
  # -----------------------------------------------
  init: =>

    @show(@param.id * 0.02)






  # -----------------------------------------------
  #
  # -----------------------------------------------
  show: (delay) =>

    sw = window.innerWidth
    sh = window.innerHeight

    kake = 0.5

    @param.position.set(
      Util.range(sw * kake),
      Util.range(sh * kake),
      Util.range(Math.max(sw, sh) * kake)
    )

    # @param.radius = Util.range(Math.max(sw, sh) * 0.5, Math.max(sw, sh)) * 1
    @param.radius = Math.max(sw, sh) * kake
    @param.speed = Util.range(3)
    @param.angle = Util.range(360)

    @rotation.set(
      Util.radian(Util.random(0, 360)),
      Util.radian(Util.random(0, 360)),
      Util.radian(Util.random(0, 360))
    )

    @param.aroundSpeed = Util.range(2)

    # if Param.mesh.small.value && Util.hit(2)
    #   scale = Util.random(0.02, 0.1)
    #   # scale = Util.random(20, 22)
    # else
    scale = Util.random(0.5, 1)
    scale *= 1

    @param.isSmall = Util.hit(3)
    @param.isNoise = Util.hit(20)

    duration = 1
    delay = delay || 0

    switch Param.mesh.easing.value
      when 'Expo'
        ease = Expo.easeInOut
      when 'Elastic'
        ease = Elastic.easeOut.config(1, 0.5)

    Tween.a(@param, {
      scale:scale
    }, duration, delay, ease, null, null, @_eShowed)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  hide: =>

    duration = 1
    delay = Util.random(0, 1)
    ease = Expo.easeIn

    Tween.a(@param, {
      scale:0
    }, duration, delay, ease, null, null, @_eHided)




  # -----------------------------------------------
  #
  # -----------------------------------------------
  _eShowed: =>

    @hide()



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _eHided: =>

    @show()




  # -----------------------------------------------
  #
  # -----------------------------------------------
  update: =>

    sw = window.innerWidth
    sh = window.innerHeight
    cnt = @param.id * 100 + Update.cnt

    scale = Math.max(0.001, @param.scale * Math.min(sw, sh) * 0.15)

    if Param.mesh.small.value && @param.isSmall && !@param.isNoise
      scale *= 0.1

    if @param.isNoise && Param.mesh.noise.value
      @scale.set(scale * 20, scale * 0.02, scale * 0.02)
    else
      @scale.set(scale, scale, scale)


    mat = @material

    # 色
    if Param.mesh.color.value

      radian = Util.radian(cnt * 5)
      cA = new THREE.Color(0xff0000)
      cB = new THREE.Color(0x00ff00)
      mat.color = cA.lerp(cB, Util.map(Math.sin(radian), 0, 1, -1, 1))

      cA = new THREE.Color(0x000000)
      cB = new THREE.Color(0x0000ff)
      mat.emissive = cA.lerp(cB, Util.map(Math.sin(radian * .8), 0, 1, -1, 1))

    else

      mat.color.setHex(0xff0000)
      mat.emissive.setHex(0x000000)


    move = Param.mesh.move.value

    if Param.mesh.guruguru.value
      radian = Util.radian(@param.angle)
      @position.x = Math.sin(radian) * @param.radius
      @position.z = Math.cos(radian) * @param.radius
      @position.y = @param.position.y
      @position.x += Math.sin(cnt * 0.111) * move
      @position.y += Math.cos(cnt * 0.088) * move
      @position.z += Math.sin(cnt * 0.098) * move
    else
      @position.x = @param.position.x + Math.sin(cnt * 0.111) * move
      @position.y = @param.position.y + Math.cos(cnt * 0.088) * move
      @position.z = @param.position.z + Math.sin(cnt * 0.098) * move

    @param.angle += @param.speed * 0.5

    # if Param.mesh.around.value
    #   kake = 5
    #   @rotation.x += @param.aroundSpeed * 0.0012 * kake
    #   @rotation.y += @param.aroundSpeed * 0.0088 * kake
    #   @rotation.z += @param.aroundSpeed * 0.0093 * kake






module.exports = MyMesh
