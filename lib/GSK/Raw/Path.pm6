use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Graphene::Raw::Definitions;
use GSK::Raw::Definitions;
use GSK::Raw::Enums;
use GSK::Raw::Structs;

unit package GSK::Raw::Path:ver<4>;

### /usr/src/gtk4/gsk/gskpath.h

sub gsk_path_foreach (
  GskPath             $self,
  GskPathForeachFlags $flags,
                      &func (
                        GskPathOperation,
                        graphene_point_t,
                        gsize,
                        gfloat,
                        gpointer
                        --> gboolean
                      ),
  gpointer            $user_data
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_get_bounds (
  GskPath         $self,
  graphene_rect_t $bounds
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_get_closest_point (
  GskPath          $self,
  graphene_point_t $point,
  gfloat           $threshold,
  GskPathPoint     $result,
  gfloat           $distance is rw
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_get_end_point (
  GskPath      $self,
  GskPathPoint $result
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_get_start_point (
  GskPath      $self,
  GskPathPoint $result
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_get_stroke_bounds (
  GskPath         $self,
  GskStroke       $stroke,
  graphene_rect_t $bounds
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_path_in_fill (
  GskPath          $self,
  graphene_point_t $point,
  GskFillRule      $fill_rule
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_is_closed (GskPath $self)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_is_empty (GskPath $self)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_parse (Str $string)
  returns GskPath
  is      native(gsk)
  is      export
{ * }

sub gsk_path_print (
  GskPath $self,
  GString $string
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_ref (GskPath $self)
  returns GskPath
  is      native(gsk)
  is      export
{ * }

sub gsk_path_to_cairo (
  GskPath        $self,
  Cairo::cairo_t $cr
)
  is      native(gsk)
  is      export
{ * }

sub gsk_path_to_string (GskPath $self)
  returns Str
  is      native(gsk)
  is      export
{ * }

sub gsk_path_unref (GskPath $self)
  is      native(gsk)
  is      export
{ * }
