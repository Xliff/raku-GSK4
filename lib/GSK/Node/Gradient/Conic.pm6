use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method conic_gradient_node_get_angle (GskRenderNode $node) {
  gsk_conic_gradient_node_get_angle($node);
}

method conic_gradient_node_get_center (GskRenderNode $node) {
  gsk_conic_gradient_node_get_center($node);
}

method conic_gradient_node_get_color_stops (
  GskRenderNode $node,
  gsize         $n_stops
) {
  gsk_conic_gradient_node_get_color_stops($node, $n_stops);
}

method conic_gradient_node_get_n_color_stops (GskRenderNode $node) {
  gsk_conic_gradient_node_get_n_color_stops($node);
}

method conic_gradient_node_get_rotation (GskRenderNode $node) {
  gsk_conic_gradient_node_get_rotation($node);
}

method conic_gradient_node_get_type {
  gsk_conic_gradient_node_get_type();
}

method conic_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $rotation,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
) {
  gsk_conic_gradient_node_new($bounds, $center, $rotation, $color_stops, $n_color_stops);
}
