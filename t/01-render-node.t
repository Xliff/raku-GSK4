use GSK::Raw::Types;

use GLib::Bytes;
use GDK::Surface;
use GDK::Texture::Memory;
use GSK::RenderNode;
use GSK::Renderer;

sub deserialize-error ($s, $e, $error, $ud) {
  my $s = '<data>';
  $s ~= "{ $s.lines.succ }:{ $s.line_chars.succ }";

  if $s.lines != $e.lines || $s.line-chars != $e.line-chars {
    $s ~= '-';
    $s ~= "{ $e.lines.succ }:" if $s.lines != $e.lines;
    $s ~= "{ $e.line-chars.succ }";
  }

  $*ERR.say: "Error at { $s }: { $error.message }":
}

sub do-fallback ($node) {
  my  $bounds          =  $node.get-bounds;
  my ($width, $height) = ($bounds.size.width, $bounds.size.height)».ceiling;
  my  $stride          =  $width * 4;
  my  $pixels          =  CArray[uint8].allocate($stride * $height);
  my  $texture;

  my $surface = Cairo::Image.create(
    CAIRO_FORMAT_ARGB32,
    $width,
    $height,
    $pixels,
    $stride
  );
  my $cr = Cairo::Context.create($surface);
  for ^$runs {
    if $_ {
      $cr.save;
      $cr.operator = OPEATOR_CLEAR;
      $cr.paint;
      $cr.restore;
    }
    {
      $node.draw($cr);
      my $time = now - ENTER now;
      say "Run { $_}: Rendered fallback in { $time }s" if $benchmark;
    }
    $texture = GDK::Texture::Memory.new(
      $width,
      $height,
      $pixels,
      $stride
    );
  }
  $texture;
}

sub do-renderer ($node) {
  my $window   = GDK::Surface.new-toplevel( GDK::Display.default )
  my $renderer = GSK::Renderer.new-for-surface($window);
  my $texture;

  for ^$runs {
    if $_ {
      {
        $texture = $renderer.render-texture($node);
        my $time = now - ENTER now;
        say "Run { $_ }: Rendered using {
             $renderer.objectType.name } in { $time }s";
      }
    }
  }
  $renderer.unrealize;
  $window.unref;
  $renderer.unref;
  $texture;
}

sub MAIN (
           $node-file,
           $png-file,
  Bool :b(:$benchmnark),   #= Time operations,
  Bool :d(:$dump-variant), #= Dump variant structure
  Bool :f(:$fallback),     #= Draw node without a renderer
  Int  :r(:$runs)          #= Render the test N times
) {
  gtk-init();

  unless ( my $contents = $node-file.IO.slurp(:bin) ) {
    say "Could not open node file: { $! }";
    exit 1;
  }

  my $bytes = GLib::Bytes.new-take($contents);
  if $dump-variant {
    my $variant = GLib::Bytes.new_from_bytes(
      GLib::VariantType.check( '(suuv)' ),
      $bytes
    );
    say "{ $variant.print }";
    $variant.unref;
  }

  my $node;
  {
    $node = GSK::RenderNode.deserialized(
      $bytes,
      -> *@a { deserialize-error( |@a ) }
    );
    my $time = now - ENTER now;
    say "Loaded { $bytes.get-size } bytes in { $time }s"
  }

  exit 1 unless $node;

  my $texture = $fallback ?? do-fallback($node) !! do-renderer($node);
  $node.unref;

  if $png-file {
    unless $texture.safe-to-png($png-file) {
      $*ERR.say: "Failed to save PNG file: { $! }";
    }
  }
}
