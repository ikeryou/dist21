Param    = require('../core/Param')
Conf     = require('../core/Conf')
Func     = require('../core/Func')
Util     = require('../libs/Util')
Update    = require('../libs/Update')
Resize    = require('../libs/Resize')


class MyObject3D extends THREE.Object3D

  constructor: ->

    super()

    @_cnt = 0

    @isActive = true
    @flashCnt = -1
    @minScale = 0.001



  # -----------------------------------
  # 初期化
  # -----------------------------------
  init: =>

    Update.add(@_update)
    Resize.add(@_resize)



  # -----------------------------------------------
  # 破棄
  # -----------------------------------------------
  dispose: =>

    Resize.remove(@_resize)
    Update.remove(@_update)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  setActive: (bool) =>

    @isActive = bool



  # -----------------------------------
  #
  # -----------------------------------
  flash: =>

    if @flashCnt >= 0
      @visible = (@flashCnt % 2 == 0)
      @flashCnt--



  # -----------------------------------
  #
  # -----------------------------------
  _update: =>

    @_cnt++




  # -----------------------------------
  #
  # -----------------------------------
  _resize: =>




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
    camera.far = 10000
    camera.zoom = 1
    camera.updateProjectionMatrix()
    camera.position.set(0, 0, 1)
    camera.lookAt(new THREE.Vector3(0, 0, 0))



  # ------------------------------------
  # コクのあるサイン 2
  # ------------------------------------
  sin2: (radian) =>

    return (
      Math.sin(radian) +
      Math.sin(2.2 * radian + 5.52) +
      Math.sin(2.9 * radian + 0.93) +
      Math.sin(4.6 * radian + 8.94)
    ) / 4



  # -----------------------------------------------
  #
  # -----------------------------------------------
  makeTex: (src) =>

    tex = new THREE.TextureLoader().load(src)
    if !isMobile.any
      tex.magFilter = THREE.LinearFilter
      tex.minFilter = THREE.LinearFilter
    else
      tex.magFilter = THREE.NearestFilter
      tex.minFilter = THREE.NearestFilter

    return tex









module.exports = MyObject3D
