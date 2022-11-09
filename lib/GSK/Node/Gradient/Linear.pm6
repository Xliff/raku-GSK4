use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;

method linear_gradient_node_get_color_stops (
  GskRenderNode $node,
  gsize         $n_stops
) {
  gsk_linear_gradient_node_get_color_stops($node, $n_stops);
}

method linear_gradient_node_get_end (GskRenderNode $node) {
  gsk_linear_gradient_node_get_end($node);
}

method linear_gradient_node_get_n_color_stops (GskRenderNode $node) {
  gsk_linear_gradient_node_get_n_color_stops($node);
}

method linear_gradient_node_get_start (GskRenderNode $node) {
  gsk_linear_gradient_node_get_start($node);
}

method linear_gradient_node_get_type {
  gsk_linear_gradient_node_get_type();
}

method linear_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $start,
  graphene_point_t $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
) {
  gsk_linear_gradient_node_new($bounds, $start, $end, $color_stops, $n_color_stops);
}
