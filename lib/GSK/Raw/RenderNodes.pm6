use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Graphene::Raw::Definitions;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use Pango::Raw::Structs;
use GDK::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GSK::Raw::Definitions:ver<4>;
use GSK::Raw::Enums:ver<4>;
use GSK::Raw::Structs:ver<4>;

unit package GSK::Raw::RenderNodes;

### /usr/src/gtk4-4.8.1+ds/gsk/gskrendernode.h

sub gsk_blur_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_blur_node_get_radius (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_blur_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_blur_node_new (
  GskRenderNode $child,
  gfloat        $radius
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_colors (GskRenderNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_outline (GskRenderNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_widths (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_new (
  GskRoundedRect $outline,
  gfloat         $border_width,
  GdkRGBA        $border_color
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_node_get_draw_context (GskRenderNode $node)
  returns cairo_t
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_node_get_surface (GskRenderNode $node)
  returns cairo_surface_t
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_node_new (graphene_rect_t $bounds)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_clip_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_clip_node_get_clip (GskRenderNode $node)
  returns graphene_rect_t
  is      native(gsk)
  is      export
{ * }

sub gsk_clip_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_clip_node_new (
  GskRenderNode   $child,
  graphene_rect_t $clip
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_get_color_matrix (GskRenderNode $node)
  returns graphene_matrix_t
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_get_color_offset (GskRenderNode $node)
  returns graphene_vec4_t
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_new (
  GskRenderNode     $child,
  graphene_matrix_t $color_matrix,
  graphene_vec4_t   $color_offset
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_color_node_get_color (GskRenderNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_color_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_color_node_new (
  GdkRGBA         $rgba,
  graphene_rect_t $bounds
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_angle (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_center (GskRenderNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_color_stops (
  GskRenderNode $node,
  gsize         $n_stops
)
  returns GskColorStop
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_n_color_stops (GskRenderNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_rotation (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $rotation,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_container_node_get_child (
  GskRenderNode $node,
  guint         $idx
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_container_node_get_n_children (GskRenderNode $node)
  returns guint
  is      native(gsk)
  is      export
{ * }

sub gsk_container_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_container_node_new (
  CArray[GskRenderNode] $children,
  guint                 $n_children
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_end_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_progress (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_start_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_new (
  GskRenderNode $start,
  GskRenderNode $end,
  gfloat        $progress
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_debug_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_debug_node_get_message (GskRenderNode $node)
  returns Str
  is      native(gsk)
  is      export
{ * }

sub gsk_debug_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_debug_node_new (
  GskRenderNode $child,
  Str           $message
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_args (GskRenderNode $node)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_child (
  GskRenderNode $node,
  guint         $idx
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_n_children (GskRenderNode $node)
  returns guint
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_shader (GskRenderNode $node)
  returns GskGLShader
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_new (
  GskGLShader           $shader,
  graphene_rect_t       $bounds,
  GBytes                $args,
  CArray[GskRenderNode] $children,
  guint                 $n_children
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_blur_radius (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_color (GskRenderNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_dx (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_dy (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_outline (GskRenderNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_spread (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_new (
  GskRoundedRect $outline,
  GdkRGBA        $color,
  gfloat         $dx,
  gfloat         $dy,
  gfloat         $spread,
  gfloat         $blur_radius
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_color_stops (
  GskRenderNode $node,
  gsize         $n_stops
)
  returns GskColorStop
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_end (GskRenderNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_n_color_stops (GskRenderNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_start (GskRenderNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $start,
  graphene_point_t $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_opacity_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_opacity_node_get_opacity (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_opacity_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_opacity_node_new (
  GskRenderNode $child,
  gfloat        $opacity
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_blur_radius (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_color (GskRenderNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_dx (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_dy (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_outline (GskRenderNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_spread (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_new (
  GskRoundedRect $outline,
  GdkRGBA        $color,
  gfloat         $dx,
  gfloat         $dy,
  gfloat         $spread,
  gfloat         $blur_radius
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_center (GskRenderNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_color_stops (
  GskRenderNode $node,
  gsize         $n_stops
)
  returns GskColorStop
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_end (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_hradius (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_n_color_stops (GskRenderNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_start (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_vradius (GskRenderNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $hradius,
  gfloat           $vradius,
  gfloat           $start,
  gfloat           $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_deserialize (
  GBytes            $bytes,
                    &error_func (
                      GskParseLocation,
                      GskParseLocation,
                      GError,
                      gpointer
                    ),
  gpointer          $user_data
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_draw (
  GskRenderNode $node,
  cairo_t       $cr
)
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_get_bounds (
  GskRenderNode   $node,
  graphene_rect_t $bounds
)
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_get_node_type (GskRenderNode $node)
  returns GskRenderNodeType
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_ref (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_serialize (GskRenderNode $node)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_unref (GskRenderNode $node)
  is      native(gsk)
  is      export
{ * }

sub gsk_render_node_write_to_file (
  GskRenderNode           $node,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_repeat_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_repeat_node_get_child_bounds (GskRenderNode $node)
  returns graphene_rect_t
  is      native(gsk)
  is      export
{ * }

sub gsk_repeat_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_repeat_node_new (
  graphene_rect_t $bounds,
  GskRenderNode   $child,
  graphene_rect_t $child_bounds
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_repeating_linear_gradient_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_repeating_linear_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $start,
  graphene_point_t $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_repeating_radial_gradient_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_repeating_radial_gradient_node_new (
  graphene_rect_t  $bounds,
  graphene_point_t $center,
  gfloat           $hradius,
  gfloat           $vradius,
  gfloat           $start,
  gfloat           $end,
  GskColorStop     $color_stops,
  gsize            $n_color_stops
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_clip_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_clip_node_get_clip (GskRenderNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_clip_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_clip_node_new (
  GskRenderNode  $child,
  GskRoundedRect $clip
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_serialization_error_quark
  returns GQuark
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_n_shadows (GskRenderNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_shadow (
  GskRenderNode $node,
  gsize         $i
)
  returns GskShadow
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_new (
  GskRenderNode $child,
  GskShadow     $shadows,
  gsize         $n_shadows
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_color (GskRenderNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_font (GskRenderNode $node)
  returns PangoFont
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_glyphs (
  GskRenderNode $node,
  guint         $n_glyphs is rw
)
  returns PangoGlyphInfo
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_num_glyphs (GskRenderNode $node)
  returns guint
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_offset (GskRenderNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_has_color_glyphs (GskRenderNode $node)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_new (
  PangoFont        $font,
  PangoGlyphString $glyphs,
  GdkRGBA          $color,
  graphene_point_t $offset
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_texture_node_get_texture (GskRenderNode $node)
  returns GdkTexture
  is      native(gsk)
  is      export
{ * }

sub gsk_texture_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_texture_node_new (
  GdkTexture      $texture,
  graphene_rect_t $bounds
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_node_get_child (GskRenderNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_node_get_transform (GskRenderNode $node)
  returns GskTransform
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_node_new (
  GskRenderNode $child,
  GskTransform  $transform
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_value_dup_render_node (GValue $value)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_value_get_render_node (GValue $value)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_value_set_render_node (
  GValue        $value,
  GskRenderNode $node
)
  is      native(gsk)
  is      export
{ * }

sub gsk_value_take_render_node (
  GValue        $value,
  GskRenderNode $node
)
  is      native(gsk)
  is      export
{ * }
