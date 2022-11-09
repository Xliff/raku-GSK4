
use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use Graphene::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GSK::Raw::Definitions:ver<4>;

unit package GSK::Raw::Renderer:ver<4>;

### /usr/include/gtk-4.0/gsk/gskrenderer.h

sub gsk_renderer_get_surface (GskRenderer $renderer)
  returns GdkSurface
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_is_realized (GskRenderer $renderer)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_new_for_surface (GdkSurface $surface)
  returns GskRenderer
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_realize (
  GskRenderer             $renderer,
  GdkSurface              $surface,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_render (
  GskRenderer    $renderer,
  GskRenderNode  $root,
  cairo_region_t $region
)
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_render_texture (
  GskRenderer     $renderer,
  GskRenderNode   $root,
  graphene_rect_t $viewport
)
  returns GdkTexture
  is      native(gsk)
  is      export
{ * }

sub gsk_renderer_unrealize (GskRenderer $renderer)
  is      native(gsk)
  is      export
{ * }
