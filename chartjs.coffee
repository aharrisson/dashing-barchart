class Dashing.Chartjs extends Dashing.Widget

  ready: ->
    # Margins: zero if not set or the same as the opposite margin
    # (you likely want this to keep the chart centered within the widget)
    left = @get('leftMargin') || 0
    right = @get('rightMargin') || left
    top = @get('topMargin') || 0
    bottom = @get('bottomMargin') || top

    container = $(@node).parent()
    # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1) - left - right
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey")) - 35 - top - bottom

    # Lower the chart's height to make space for moreinfo if not empty
    if !!@get('moreinfo')
      height -= 20

    $holder = $("<div class='canvas-holder' style='left:#{left}px; top:#{top}px; position:absolute;'></div>")
    $(@node).append $holder

    canvas = $(@node).find('.canvas-holder')
    canvas.append("<canvas width=\"#{width}\" height=\"#{height}\" class=\"chart-area\"/>")

    @ctx = $(@node).find('.chart-area')[0].getContext('2d')

    @myChart = new Chart(@ctx, {
      type: @get('type'),
      data: @get('data'),
      options: @get('options')
    })

  onData: (data) ->
    if @myChart
        if data.data
            @myChart.config.data = data.data
        if data.type
            @myChart.config.type = data.type
        if data.options
            @myChart.config.data = data.options
      @myChart.update()
