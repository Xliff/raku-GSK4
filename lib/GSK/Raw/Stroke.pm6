use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GSK::Raw::Definitions:ver<4>;
use GSK::Raw::Enums:ver<4>;

unit package GSK::Raw::Stroke:ver<4>;

### /usr/src/gtk4/gsk/gskstroke.h

sub gsk_stroke_copy (GskStroke $other)
  returns GskStroke
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_equal (
  GskStroke $stroke1,
  GskStroke $stroke2
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_free (GskStroke $self)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_dash (
  GskStroke $self,
  gsize     $n_dash
)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_dash_offset (GskStroke $self)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_line_cap (GskStroke $self)
  returns GskLineCap
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_line_join (GskStroke $self)
  returns GskLineJoin
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_line_width (GskStroke $self)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_miter_limit (GskStroke $self)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_new (gfloat $line_width)
  returns GskStroke
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_set_dash (
  GskStroke      $self,
  CArray[gfloat] $dash,
  gsize          $n_dash
)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_set_dash_offset (
  GskStroke $self,
  gfloat    $offset
)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_set_line_cap (
  GskStroke  $self,
  GskLineCap $line_cap
)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_set_line_join (
  GskStroke   $self,
  GskLineJoin $line_join
)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_set_line_width (
  GskStroke $self,
  gfloat    $line_width
)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_set_miter_limit (
  GskStroke $self,
  gfloat    $limit
)
  is      native(gsk)
  is      export
{ * }

sub gsk_stroke_to_cairo (
  GskStroke      $self,
  Cairo::cairo_t $cr
)
  is      native(gsk)
  is      export
{ * }
