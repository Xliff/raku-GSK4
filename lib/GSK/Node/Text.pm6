use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;


method text_node_get_color (GskRenderNode $node) {
  gsk_text_node_get_color($node);
}

method text_node_get_font (GskRenderNode $node) {
  gsk_text_node_get_font($node);
}

method text_node_get_glyphs (
  GskRenderNode $node,
  guint         $n_glyphs is rw
) {
  gsk_text_node_get_glyphs($node, $n_glyphs);
}

method text_node_get_num_glyphs (GskRenderNode $node) {
  gsk_text_node_get_num_glyphs($node);
}

method text_node_get_offset (GskRenderNode $node) {
  gsk_text_node_get_offset($node);
}

method text_node_get_type {
  gsk_text_node_get_type();
}

method text_node_has_color_glyphs (GskRenderNode $node) {
  gsk_text_node_has_color_glyphs($node);
}

method text_node_new (
  PangoFont        $font,
  PangoGlyphString $glyphs,
  GdkRGBA          $color,
  graphene_point_t $offset
) {
  gsk_text_node_new($font, $glyphs, $color, $offset);
}
