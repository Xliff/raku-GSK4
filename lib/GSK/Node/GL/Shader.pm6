use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method gl_shader_node_get_args (GskRenderNode $node) {
  gsk_gl_shader_node_get_args($node);
}

method gl_shader_node_get_child (
  GskRenderNode $node,
  guint         $idx
) {
  gsk_gl_shader_node_get_child($node, $idx);
}

method gl_shader_node_get_n_children (GskRenderNode $node) {
  gsk_gl_shader_node_get_n_children($node);
}

method gl_shader_node_get_shader (GskRenderNode $node) {
  gsk_gl_shader_node_get_shader($node);
}

method gl_shader_node_get_type {
  gsk_gl_shader_node_get_type();
}

method gl_shader_node_new (
  GskGLShader           $shader,
  graphene_rect_t       $bounds,
  GBytes                $args,
  CArray[GskRenderNode] $children,
  guint                 $n_children
) {
  gsk_gl_shader_node_new($shader, $bounds, $args, $children, $n_children);
}
