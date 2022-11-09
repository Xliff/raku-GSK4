use v6.c;

use GLib::Raw::Exports;
use Pango::Raw::Exports;
use GIO::Raw::Exports;
use Graphene::Raw::Exports;
use GDK::Pixbuf::Raw::Exports;
use GDK::Raw::Exports:ver<4>;
use GSK::Raw::Exports:ver<4>;

unit package GDK::Raw::Types:ver<4>;

need Cairo;
need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need GLib::Roles::Implementor;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;
need GIO::DBus::Raw::Types;
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Quarks;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::Raw::Exports;
need Graphene::Raw::Definitions;
need Graphene::Raw::Enums;
need GDK::Pixbuf::Raw::Definitions;
need GDK::Pixbuf::Raw::Enums;
need GDK::Pixbuf::Raw::Structs;
need GDK::Raw::Compat:ver<4>;
need GDK::Raw::Definitions:ver<4>;
need GDK::Raw::Enums:ver<4>;
need GDK::Raw::Structs:ver<4>;
need GDK::Raw::Subs:ver<4>;
need GSK::Raw::Definitions:ver<4>;
need GSK::Raw::Enums:ver<4>;
need GSK::Raw::Structs:ver<4>;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@pango-exports,
                         |@gio-exports,
                         |@gdk-pixbuf-exports,
                         |@graphene-exports,
                         |@gdk4-exports,
                         |@gsk4-exports;
}
