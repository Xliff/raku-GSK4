use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method inset_shadow_node_get_blur_radius (GskRenderNode $node) {
  gsk_inset_shadow_node_get_blur_radius($node);
}

method inset_shadow_node_get_color (GskRenderNode $node) {
  gsk_inset_shadow_node_get_color($node);
}

method inset_shadow_node_get_dx (GskRenderNode $node) {
  gsk_inset_shadow_node_get_dx($node);
}

method inset_shadow_node_get_dy (GskRenderNode $node) {
  gsk_inset_shadow_node_get_dy($node);
}

method inset_shadow_node_get_outline (GskRenderNode $node) {
  gsk_inset_shadow_node_get_outline($node);
}

method inset_shadow_node_get_spread (GskRenderNode $node) {
  gsk_inset_shadow_node_get_spread($node);
}

method inset_shadow_node_get_type {
  gsk_inset_shadow_node_get_type();
}

method inset_shadow_node_new (
  GskRoundedRect $outline,
  GdkRGBA        $color,
  gfloat         $dx,
  gfloat         $dy,
  gfloat         $spread,
  gfloat         $blur_radius
) {
  gsk_inset_shadow_node_new($outline, $color, $dx, $dy, $spread, $blur_radius);
}
