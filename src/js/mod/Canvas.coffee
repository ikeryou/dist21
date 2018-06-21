MyDisplay = require('../core/MyDisplay')
Param     = require('../core/Param')
Conf      = require('../core/Conf')
Func      = require('../core/Func')
Util      = require('../libs/Util')
Profiler  = require('../core/Profiler')


class Canvas extends MyDisplay


  constructor: (opt) ->

    super({
      update:true
      resize:true
      el:opt.el
    })

    @camera
    @renderer
    @mainScene

    @isOrthographic = false
    @isRender = true



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    @_makeRenderer()
    @_makeMainScene()



  # -----------------------------------------------
  # 破棄
  # -----------------------------------------------
  dispose: =>

    @camera = null
    @mainScene = null

    @renderer.forceContextLoss()
    @renderer.context = null
    @renderer.domElement = null
    @renderer.dispose()
    @renderer = null

    super()



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    super()

    @renderer.autoClear = true
    @renderer.render(@mainScene, @camera)



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>

    # 画面サイズ
    w = window.innerWidth
    h = window.innerHeight

    @camera.aspect = w / h
    @camera.updateProjectionMatrix()

    @renderer.setPixelRatio(Func.ratio())
    @renderer.setSize(w, h, true)
    @renderer.clear()



  # -----------------------------------------------
  # カメラ作成
  # -----------------------------------------------
  _makeCamera: (param) =>

    param = param || {}

    @isOrthographic = param.isOrthographic

    if @isOrthographic
      return new THREE.OrthographicCamera()
    else
      return new THREE.PerspectiveCamera(45, 1, 0.1, 50000)



  # -----------------------------------------------
  # カメラ設定
  # -----------------------------------------------
  updateCamera: (camera, w, h) =>

    if @isOrthographic
      @_updateOrthographicCamera(camera, w, h)
    else
      @_updatePerspectiveCamera(camera, w, h)



  # -----------------------------------------------
  # Perspectiveカメラ設定
  # -----------------------------------------------
  _updatePerspectiveCamera: (camera, w, h) =>

    w = w || 10
    h = h || 10

    camera.aspect = w / h
    camera.updateProjectionMatrix()
    camera.position.z = h / Math.tan(camera.fov * Math.PI / 360) / 2



  # -----------------------------------------------
  # Orthographicカメラ設定
  # -----------------------------------------------
  _updateOrthographicCamera: (camera, w, h) =>

    w = w || 10
    h = h || 10

    camera.left = -w * 0.5
    camera.right = w * 0.5
    camera.top = h * 0.5
    camera.bottom = -h * 0.5
    camera.near = 0.1
    camera.far = 100000
    camera.zoom = 1
    camera.updateProjectionMatrix()
    camera.position.set(0, 0, 1)
    camera.lookAt(new THREE.Vector3(0, 0, 0))



  # -----------------------------------------------
  # レンダラー作成
  # -----------------------------------------------
  _makeRenderer: =>

    @renderer = new THREE.WebGLRenderer({
      canvas             : @el().get(0)
      alpha              : false
      antialias          : false
      stencil            : false
      depth              : true
      powerPreference    : 'low-power'
    })
    @renderer.autoClear = true
    @renderer.setClearColor(0x000000, 1)

    if Util.isSafari() || Util.isFF()
      @renderer.context.getShaderInfoLog = =>
        return ''



  # -----------------------------------------------
  # メインシーン作成
  # -----------------------------------------------
  _makeMainScene: =>

    @mainScene = new THREE.Scene()



  # -----------------------------------------------
  # このフレームでレンダリングするかどうか
  # -----------------------------------------------
  isNowRenderFrame: =>

    return (@_cnt % 2 == 0)










module.exports = Canvas
