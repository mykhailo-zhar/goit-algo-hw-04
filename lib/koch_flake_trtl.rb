# frozen_string_literal: true

require 'trtl'

# Koch Flake
#
# The Koch Flake is a fractal that is created by starting with a triangle and then
# adding triangles to the sides of the triangle.
module KochFlake
  def self.koch_curve(trtl, order, size)
    if order.zero?
      trtl.forward(size)
      return
    end

    [60, -120, 60, 0].each do |angle|
      koch_curve(trtl, order - 1, size / 3)
      trtl.left(angle)
    end
  end

  def self.koch_flake(trtl, order, size)
    3.times do
      koch_curve(trtl, order, size)
      trtl.right(120)
    end
  end
end

size = 300

trtl = Trtl.new
trtl.pen_up
trtl.goto(size / 2, size / 2)
trtl.pen_down
KochFlake.koch_flake(trtl, 3, size)
trtl.ensure_drawn

trtl.wait
