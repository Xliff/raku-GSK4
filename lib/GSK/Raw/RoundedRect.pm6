use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Graphene::Raw::Definitions;
use GSK::Raw::Definitions:ver<4>;
use GSK::Raw::Structs:ver<4>;

unit package GSK::Raw::RoundedRect:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gsk/gskroundedrect.h

sub gsk_rounded_rect_contains_point (
  GskRoundedRect   $self,
  graphene_point_t $point
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_contains_rect (
  GskRoundedRect  $self,
  graphene_rect_t $rect
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_init (
  GskRoundedRect  $self,
  graphene_rect_t $bounds,
  graphene_size_t $top_left,
  graphene_size_t $top_right,
  graphene_size_t $bottom_right,
  graphene_size_t $bottom_left
)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_init_copy (
  GskRoundedRect $self,
  GskRoundedRect $src
)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_init_from_rect (
  GskRoundedRect  $self,
  graphene_rect_t $bounds,
  gfloat          $radius
)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_intersects_rect (
  GskRoundedRect  $self,
  graphene_rect_t $rect
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_is_rectilinear (GskRoundedRect $self)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_normalize (GskRoundedRect $self)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_offset (
  GskRoundedRect $self,
  gfloat         $dx,
  gfloat         $dy
)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }

sub gsk_rounded_rect_shrink (
  GskRoundedRect $self,
  gfloat         $top,
  gfloat         $right,
  gfloat         $bottom,
  gfloat         $left
)
  returns GskRoundedRect
  is      native(gsk)
  is      export
{ * }
