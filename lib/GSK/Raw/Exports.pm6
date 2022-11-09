use v6.c;

unit package GSK::Raw::Exports:ver<4>;

our @gsk4-exports is export;

BEGIN {
  @gsk4-exports = <
    GSK::Raw::Definitions
    GSK::Raw::Enums
    GSK::Raw::Structs
  >;
}
