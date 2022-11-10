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

sub gsk_blur_node_get_child (GskBlurNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_blur_node_get_radius (GskBlurNode $node)
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

sub gsk_border_node_get_colors (GskBorderNode $node)
  returns gpointer # Array of GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_outline (GskBorderNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_get_widths (GskBorderNode $node)
  returns CArray[gfloat]
  is      native(gsk)
  is      export
{ * }

sub gsk_border_node_new (
  GskRoundedRect $outline,
  gfloat         $border_width,
  GdkRGBA        $border_color
)
  returns GskBorderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_node_get_draw_context (GskCairoNode $node)
  returns cairo_t
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_node_get_surface (GskCairoNode $node)
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
  returns GskCairoNode
  is      native(gsk)
  is      export
{ * }

sub gsk_clip_node_get_child (GskClipNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_clip_node_get_clip (GskClipNode $node)
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

sub gsk_color_matrix_node_get_child (GskColorMatrixNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_get_color_matrix (GskColorMatrixNode $node)
  returns graphene_matrix_t
  is      native(gsk)
  is      export
{ * }

sub gsk_color_matrix_node_get_color_offset (GskColorMatrixNode $node)
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

sub gsk_color_node_get_color (GskColorNode $node)
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
  returns GskColorNode
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_angle (GskConicGradientNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_center (GskConicGradientNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_color_stops (
  GskConicGradientNode $node,
  gsize         $n_stops
)
  returns GskColorStop
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_n_color_stops (GskConicGradientNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_conic_gradient_node_get_rotation (GskConicGradientNode $node)
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
  returns GskConicGradientNode
  is      native(gsk)
  is      export
{ * }

sub gsk_container_node_get_child (
  GskContainerNode $node,
  guint         $idx
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_container_node_get_n_children (GskContainerNode $node)
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
  returns GskContainerNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_end_child (GskCrossFadeNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_progress (GskCrossFadeNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_cross_fade_node_get_start_child (GskCrossFadeNode $node)
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
  returns GskCrossFadeNode
  is      native(gsk)
  is      export
{ * }

sub gsk_debug_node_get_child (GskDebugNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_debug_node_get_message (GskDebugNode $node)
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
  returns GskDebugNode
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_args (GskGLShaderNode $node)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_child (
  GskGLShaderNode $node,
  guint         $idx
)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_n_children (GskGLShaderNode $node)
  returns guint
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_node_get_shader (GskGLShaderNode $node)
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
  returns GskGLShaderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_blur_radius (GskInsetShadowNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_color (GskInsetShadowNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_dx (GskInsetShadowNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_dy (GskInsetShadowNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_outline (GskInsetShadowNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_inset_shadow_node_get_spread (GskInsetShadowNode $node)
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
  returns GskInsetShadowNode
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_color_stops (
  GskLinearGradientNode $node,
  gsize         $n_stops
)
  returns GskColorStop
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_end (GskLinearGradientNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_n_color_stops (GskLinearGradientNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_linear_gradient_node_get_start (GskLinearGradientNode $node)
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

sub gsk_opacity_node_get_child (GskLinearGradientNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_opacity_node_get_opacity (GskOpacityNode $node)
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
  returns GskOpacityNode
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_blur_radius (GskOutsetShadowNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_color (GskOutsetShadowNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_dx (GskOutsetShadowNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_dy (GskOutsetShadowNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_outline (GskOutsetShadowNode $node)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_outset_shadow_node_get_spread (GskOutsetShadowNode $node)
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
  returns GskOutsetShadowNode
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_center (GskRadialGradientNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_color_stops (
  GskRadialGradientNode $node,
  gsize         $n_stops
)
  returns GskColorStop
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_end (GskRadialGradientNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_hradius (GskRadialGradientNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_n_color_stops (GskRadialGradientNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_start (GskRadialGradientNode $node)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_radial_gradient_node_get_vradius (GskRadialGradientNode $node)
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
  returns GskRadialGradientNode
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

sub gsk_repeat_node_get_child (GskRepeatNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_repeat_node_get_child_bounds (GskRepeatNode $node)
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
  returns GskRepeatNode
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
  returns GskRepeatingLinearGradientNode
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
  returns GskRepeatingRadialGradientNode
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_clip_node_get_child (GskRoundedClipNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_clip_node_get_clip (GskRoundedClipNode $node)
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
  returns GskRoundedClipNode
  is      native(gsk)
  is      export
{ * }

sub gsk_serialization_error_quark
  returns GQuark
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_child (GskShadowNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_n_shadows (GskShadowNode $node)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_shadow_node_get_shadow (
  GskShadowNode $node,
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
  returns GskShadowNode
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_color (GskTextNode $node)
  returns GdkRGBA
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_font (GskTextNode $node)
  returns PangoFont
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_glyphs (
  GskTextNode $node,
  guint         $n_glyphs is rw
)
  returns gpointer # Array of PangoGlyphInfo
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_num_glyphs (GskTextNode $node)
  returns guint
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_offset (GskTextNode $node)
  returns graphene_point_t
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_text_node_has_color_glyphs (GskTextNode $node)
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
  returns GskTextNode
  is      native(gsk)
  is      export
{ * }

sub gsk_texture_node_get_texture (GskTextureNode $node)
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
  returns GskTextureNode
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_node_get_child (GskTransformNode $node)
  returns GskRenderNode
  is      native(gsk)
  is      export
{ * }

sub gsk_transform_node_get_transform (GskTransformNode $node)
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
  returns GskTransformNode
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
