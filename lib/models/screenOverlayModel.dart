

class ScreenOverlayModel {
  String name;
  String icon;
  double overlayX;
  double overlayY;
  double screenX;
  double screenY;
  double sizeX;
  double sizeY;

  ScreenOverlayModel({
    required this.name,
    this.icon = '',
    required this.overlayX,
    required this.overlayY,
    required this.screenX,
    required this.screenY,
    required this.sizeX,
    required this.sizeY,
  });

  String get tag => '''
      <ScreenOverlay>
        <name>$name</name>
        <Icon>
          <href>$icon</href>
        </Icon>
        <color>ffffffff</color>
        <overlayXY x="$overlayX" y="$overlayY" xunits="fraction" yunits="fraction"/>
        <screenXY x="$screenX" y="$screenY" xunits="fraction" yunits="fraction"/>
        <rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
        <size x="$sizeX" y="$sizeY" xunits="pixels" yunits="pixels"/>
      </ScreenOverlay>
    ''';


  factory ScreenOverlayModel.logos() {
    return ScreenOverlayModel(
      name: 'LogoSO',
      icon:
      'https://raw.githubusercontent.com/SagittariusA11/kml-images_RLA_LiquidGalaxy_GSoC-23/main/all_logos.png',
      overlayX: 0,
      overlayY: 1,
      screenX: 0.02,
      screenY: 0.95,
      sizeX: 558,
      sizeY: 314,
    );
  }
}
