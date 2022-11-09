use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;


use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method cross_fade_node_get_end_child (GskRenderNode $node) {
  gsk_cross_fade_node_get_end_child($node);
}

method cross_fade_node_get_progress (GskRenderNode $node) {
  gsk_cross_fade_node_get_progress($node);
}

method cross_fade_node_get_start_child (GskRenderNode $node) {
  gsk_cross_fade_node_get_start_child($node);
}

method cross_fade_node_get_type {
  gsk_cross_fade_node_get_type();
}

method cross_fade_node_new (
  GskRenderNode $start,
  GskRenderNode $end,
  gfloat        $progress
) {
  gsk_cross_fade_node_new($start, $end, $progress);
}
