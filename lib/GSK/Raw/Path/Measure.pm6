use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GSK::Raw::Definitions;
use GSK::Raw::Structs;

unit package GSK::Raw::Path::Measure:ver<4>;

### /usr/src/gtk4/gsk/gskpathmeasure.h

sub gsk_path_measure_get_length (GskPathMeasure $self)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_get_path (GskPathMeasure $self)
  returns GskPath
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_get_point (
  GskPathMeasure $self,
  gfloat         $distance,
  GskPathPoint   $result
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_get_tolerance (GskPathMeasure $self)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_new (GskPath $path)
  returns GskPathMeasure
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_new_with_tolerance (
  GskPath $path,
  gfloat  $tolerance
)
  returns GskPathMeasure
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_ref (GskPathMeasure $self)
  returns GskPathMeasure
  is      native(gsk)
  is      export
{ * }

sub gsk_path_measure_unref (GskPathMeasure $self)
  is      native(gsk)
  is      export
{ * }
