use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;


method radial_gradient_node_get_center (GskRenderNode $node) {
  gsk_radial_gradient_node_get_center($node);
}

method radial_gradient_node_get_color_stops (
  GskRenderNode $node,
  gsize         $n_stops
) {
  gsk_radial_gradient_node_get_color_stops($node, $n_stops);
}

method radial_gradient_node_get_end (GskRenderNode $node) {
  gsk_radial_gradient_node_get_end($node);
}

method radial_gradient_node_get_hradius (GskRenderNode $node) {
  gsk_radial_gradient_node_get_hradius($node);
}

method radial_gradient_node_get_n_color_stops (GskRenderNode $node) {
  gsk_radial_gradient_node_get_n_color_stops($node);
}

method radial_gradient_node_get_start (GskRenderNode $node) {
  gsk_radial_gradient_node_get_start($node);
}

method radial_gradient_node_get_type {
  gsk_radial_gradient_node_get_type();
}

method radial_gradient_node_get_vradius (GskRenderNode $node) {
  gsk_radial_gradient_node_get_vradius($node);
}

method radial_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $hradius,
  gfloat           $vradius,
  gfloat           $start,
  gfloat           $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
) {
  gsk_radial_gradient_node_new($bounds, $center, $hradius, $vradius, $start, $end, $color_stops, $n_color_stops);
}
