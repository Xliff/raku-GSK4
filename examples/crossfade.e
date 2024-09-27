use v6.c;

use GTK::Raw::Types;

use GDK::Pixbuf;
use GDK::Texture;
use Graphene::Rect;
use GSK::Node::Texture:ver<4>;
use GSK::Node::CrossFade:ver<4>;
use GTK::Application:ver<4>;
use GTK::Adjustment:ver<4>;
use GTK::Box:ver<4>;
use GTK::Frame:ver<4>;
use GTK::Image:ver<4>;
use GTK::Snapshot:ver<4>;
use GTK::Scale:ver<4>;

constant T = GDK::Texture;
constant I = GTK::Image;
constant P = GDK::Pixbuf;

my $rect;

sub update-image ($t, $i, $v = 0) {
  my @t = $t.map({ GSK::Node::Texture.new($_, $rect) });
  my $r = GSK::Node::CrossFade.new( |@t, $v );

  my $s = GTK::Snapshot.new;
  $s.append-node($r);
  $i.paintable = $s.to-paintable($rect);
}

sub MAIN ( $from? is copy, $to? is copy ) {
  my $app = GTK::Application.new(
    id     => 'org.genex.gnome.desktop.crossfade',
    width  => 1200,
    height => 1024
  );

  without $from || $to {
    my $pics = $*HOME
      .add('Pictures')
      .add('Digital Blasphemy')
      .dir
      .pick(2)
      .cache;

    $from = $pics.head without $from;
    $to   = $pics.tail without $to;
  }

  $app.activate.tap: SUB {
    my $a       = GTK::Adjustment.new( upper => 1000 );
    my $s       = GTK::Scale.new-hscale($a);
    my $f       = GTK::Frame.new;
    my $cf      = GSK::Node::CrossFade.new;
    my $b       = GTK::Box.new-vbox;
    my $tb      = GTK::Box.new-hbox(10);
    my @pb      = ($from, $to).map({ P.new_from_file($_) });
    my $tw      = @pb.map( *.width  ).max / 4;
    my $th      = @pb.map( *.height ).max / 4;
       @pb     .= map({ .scale-simple($tw, $th) });
    my @pbi     = @pb.map({ GTK::Image.new-from-pixbuf($_) });
       $rect    = Graphene::Rect.new(0, 0, $tw, $th);
    my @t       = @pb.map({ GDK::Texture.new-for-pixbuf($_) });
    my $i       = GTK::Image.new;

    $s.Value-Changed.tap: SUB {
      update-image(@t, $i, $s.value / 1000);
    }

    ( .label, .child ) = ('CrossFade', $i) given $f;
    $tb.pack_start( $_, True) for @pbi;
    $b.pack_start($f, True, True);
    $b.pack_start(  $_ ) for $s, $tb;

    update-image(@t, $i);
    $app.window.add($b);
    $app.window.present;
  }

  $app.run;
}
