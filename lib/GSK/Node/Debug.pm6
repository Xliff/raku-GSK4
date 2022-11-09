use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


  method debug_node_get_child (GskRenderNode $node) {
    gsk_debug_node_get_child($node);
  }

  method debug_node_get_message (GskRenderNode $node) {
    gsk_debug_node_get_message($node);
  }

  method debug_node_get_type {
    gsk_debug_node_get_type();
  }

  method debug_node_new (
    GskRenderNode $child,
    Str           $message
  ) {
    gsk_debug_node_new($child, $message);
  }
