use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method texture_node_get_texture (GskRenderNode $node) {
  gsk_texture_node_get_texture($node);
}

method texture_node_get_type {
  gsk_texture_node_get_type();
}

method texture_node_new (
  GdkTexture      $texture,
  graphene_rect_t $bounds
) {
  gsk_texture_node_new($texture, $bounds);
}
