use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;


method repeating_linear_gradient_node_get_type {
  gsk_repeating_linear_gradient_node_get_type();
}

method repeating_linear_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $start,
  graphene_point_t $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
) {
  gsk_repeating_linear_gradient_node_new($bounds, $start, $end, $color_stops, $n_color_stops);
}
