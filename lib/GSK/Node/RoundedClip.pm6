use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method rounded_clip_node_get_child (GskRenderNode $node) {
  gsk_rounded_clip_node_get_child($node);
}

method rounded_clip_node_get_clip (GskRenderNode $node) {
  gsk_rounded_clip_node_get_clip($node);
}

method rounded_clip_node_get_type {
  gsk_rounded_clip_node_get_type();
}

method rounded_clip_node_new (
  GskRenderNode  $child,
  GskRoundedRect $clip
) {
  gsk_rounded_clip_node_new($child, $clip);
}
