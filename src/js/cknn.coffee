svg = d3.select("#main")
  .append("svg")
  .attr("width", "100%")
  .attr("height", "100%")

class Circle
  colour: 'red'

  constructor: (@x, @y, @radius) ->

jsonCircles = [
  new Circle(100, 100, 5)
  new Circle(200, 200, 10),
]

circles = svg.selectAll("circle")
  .data jsonCircles
  .enter()
  .append("circle")

tick = ->
  jsonCircles[0].x += 1

  circleAttributes = circles
    .attr "cx", (d) -> d.x
    .attr "cy", (d) -> d.y
    .attr "r", (d) -> d.radius
    .style "fill", (d) -> d.colour

  if jsonCircles[0].x > 1000
    return true
  else
    return false

d3.timer tick, 1/60