$ ->
  $('.get-readme').live 'click', ->
    readme = $(@).parents('.repository').find('.readme')
    body = readme.find('.body')
    close = readme.find('.rclose')

    if body.find('#readme').length == 0 and !readme.data 'loading'
      readme.data 'loading', true
      addPreloader(readme)
      $.ajax
        type: "GET"
        url: @href
        dataType: 'html'
        success: (data) ->
          $('.preloader').remove()
          body.append(data)
          readme.data 'loading', false

    eachShow [body, close, $('#all-close')]
    return false

  $('.rclose').live 'click', ->
    eachHide [$(@), $(@).next()]
    if $('.body:visible').length == 0
      $('#all-close').hide()

  $('#all-close').click ->
    eachHide [$('.body:visible'), $('.rclose:visible'), $(@)]

  $('.more a').live 'click', ->
    $('.more').remove()
    addPreloader($('#watch-list'))
    $.ajax
      url: @href
      dataType: 'html'
      success: (data) ->
        $('.preloader').remove()
        $('#watch-list').append(data)
    return false

  addPreloader = (elem) ->
    elem.append '<div class="preloader"><img src="/preloader.gif"></div>'

  eachShow = (elems) ->
    for elem in elems
      elem.show()

  eachHide = (elems) ->
    for elem in elems
      elem.hide()

