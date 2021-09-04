{ stdenv, lib, fetchgit, cmake, libpng }:

stdenv.mkDerivation rec {
  pname = "qpakman";
  version = "unstable-2021-09-04";

  src = fetchgit {
    url = "https://github.com/Hamsmith-Games/qpakman";
    rev = "a626857f8658d4a42435f1a9f36fc93f35380a90";
    sha256 = "17yc9d7basljinh1pi4bfc6cld5gr8m4dq9sid8c60npnq8d92wl";
  };

  enableParallelBuilding = true;
  nativeBuildInputs = [ cmake ];
  buildInputs = [ libpng ];

  meta = with lib; {
    homepage = "https://github.com/Hamsmith-Games/qpakman";
    description = "A command-line tool for managing PAK and WAD files from QuakeI/II & Hexen II";
    license = with licenses; [ gpl2Plus ];
    maintainers = with maintainers; [ joshuafern ];
    platforms = platforms.linux;
  };
}
