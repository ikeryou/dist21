Util    = require('./libs/Util')
Update  = require('./libs/Update')
Resize  = require('./libs/Resize')
Func    = require('./core/Func')
Param   = require('./core/Param')
Canvas  = require('./mod/Canvas')
Capture = require('./mod/Capture')
MyMesh  = require('./MyMesh')


class Generate extends Canvas

  constructor: (opt) ->

    super(opt)

    @_mesh = []

    @_preScene
    @_dest
    @_light



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    @_preScene = new Capture()
    @_preScene.init()

    @camera = @_makeCamera({isOrthographic:false})
    @updateCamera(@camera)

    @_light = new THREE.DirectionalLight(0xffffff)
    @_light.position.set(0, 100, 0).normalize()
    @_preScene.add(@_light)

    num = 100
    i = 0
    while i < num
      mesh = new MyMesh({
        meshId:i
      })
      mesh.init()
      @_preScene.add(mesh)
      @_mesh.push(mesh)
      i++

    @_dest = new THREE.Mesh(
      new THREE.PlaneBufferGeometry(1, 1),
      new THREE.ShaderMaterial({
        vertexShader:require('../shader/Base.vert')
        fragmentShader:require('../shader/Dest.frag')
        uniforms:{
          tDiffuse:{value:@_preScene.texture(0)}
          invert:{value:false}
          color:{value:new THREE.Vector3(1,1,1)}
        }
      })
    )
    @mainScene.add(@_dest)

    @_resize()
    @_update()



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    sw = window.innerWidth
    sh = window.innerHeight

    cnt = Update.cnt

    if Param.light.move.value
      radian = cnt * 0.9
      @_light.intensity = Util.map(Math.sin(radian * 0.012), 0.5, 10, -1, 1)
      @_light.position.x = Math.sin(radian * 0.012) * sh * 0.5
      @_light.position.y = Math.sin(radian * 0.008) * sh * 0.5
      @_light.position.z = Math.sin(radian * 0.019) * sh * 0.5
    else
      @_light.intensity = 1
      @_light.position.set(0.5, 1, 0)

    $('.ttl').css({
      display:if Param.dom.ttl.value then '' else 'none'
    })

    stageColor = Param.all.bgColor.value
    @renderer.setClearColor(stageColor, 1)

    for val,i in @_mesh
      val.update()

    uni = @_dest.material.uniforms
    uni.invert.value = Param.posteffect.invert.value
    uni.color.value.set(
      Param.posteffect.r.value * 0.01,
      Param.posteffect.g.value * 0.01,
      Param.posteffect.b.value * 0.01
    )

    @_preScene.render(@renderer, @camera)
    @renderer.render(@mainScene, @camera)



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>

    w = window.innerWidth
    h = window.innerHeight

    @updateCamera(@camera, w, h)

    @_preScene.size(w, h)
    @_dest.scale.set(w, h, 1)

    @renderer.setPixelRatio(Func.ratio())
    @renderer.setSize(w, h)
    @renderer.clear()















module.exports = Generate
