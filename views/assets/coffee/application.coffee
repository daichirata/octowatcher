$ ->
  $('.get-readme').live 'click', ->
    readme = $(@).parents('.repository').find('.readme')
    body   = readme.find('.body')
    close  = readme.find('.rclose')
    if body.find('#readme').length == 0
      readme.append('<div class="preloader"><img src="/preloader.gif"></div>')
      $.ajax
        type: "GET"
        url: @href
        dataType: 'html'
        success: (html) =>
          $('.preloader').remove()
          body.append(html)
    body.show()
    close.show()
    return false

  $('.rclose').live 'click', ->
    $(@).next().hide()
    $(@).hide()

  $('.more a').live 'click', ->
    $('.more').append('<div class="preloader"><img src="/preloader.gif"></div>')
    $.ajax
      url: @href
      dataType: 'html'
      success: (data) ->
        $('.more').remove()
        $('#watch-list').append(data)
    return false

