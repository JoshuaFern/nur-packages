{ stdenv, lib, fetchFromGitHub, pkg-config, curl, glibmm, gtkmm3, yajl }:

stdenv.mkDerivation rec {
  pname = "samrewritten";
  version = "r133";

  src = fetchFromGitHub {
    owner = "PaulCombal";
    repo = pname;
    rev = "f75eaa9dcad0735fcd961d5b251ccb5b34360d85";
    sha256 = "0zcb6cmzk4fvbf0rkyyfvlnh9mhi0wz89parprkz6vxrj65ph1f6";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ curl glibmm gtkmm3 yajl ];

  NIX_LDFLAGS = "-lpthread";

  installPhase = ''
    install -dm755 "$out/usr/lib/"
    # Copy required files.
    mkdir -p $out/usr/lib/${pname}
    cp -r --parents ./{bin/{launch.sh,libsteam_api.so,samrewritten},glade} "$out/usr/lib/${pname}"
    # Executable
    install -dm755 "$out/bin"
    ln -s "$out/usr/lib/${pname}/bin/launch.sh" "$out/bin/samrewritten"
  '';

  meta = with stdenv.lib; {
    broken = true; # Not actually, just saving my ci time
    description = "Allows you to unlock and relock your Steam achievements";
    homepage = "https://github.com/PaulCombal/SamRewritten";
    license = licenses.gpl3;
    maintainers = with maintainers; [ joshuafern ];
    platforms = platforms.linux;
  };
}
