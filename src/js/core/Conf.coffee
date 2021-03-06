Util = require('../libs/Util')


class Conf

  constructor: ->

    # 本番フラグ
    @RELEASE = false

    # フラグ関連
    @FLG = {
      PARAM:location.href.indexOf('p=1') > 0 || location.href.indexOf('localhost') > 0
      STATS:location.href.indexOf('p=1') > 0 || location.href.indexOf('localhost') > 0
    };

    # 本番フラグがtrueの場合、フラグ関連は全てfalseに
    if @RELEASE
      for key,val of @FLG
        @FLG[key] = false

    # ブレイクポイント
    @BREAKPOINT = 768







module.exports = new Conf()
