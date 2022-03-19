import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;

  late AnimationController _animationController;
  late Animation<double> _animation;

  List<MapLatLng> coordinates = const <MapLatLng>[
    MapLatLng(56.4601802, -2.9786052),
    MapLatLng(56.4602002, -2.9786052),
    MapLatLng(56.4602132, -2.9786042),
    MapLatLng(56.4602162, -2.9786052),
    MapLatLng(56.4602182, -2.9786092),
    MapLatLng(56.4602192, -2.9786092),
    MapLatLng(56.460241, -2.9786166),
    MapLatLng(56.4602604, -2.9786329),
  ];

  @override
  void initState() {
    _mapSource = const MapShapeSource.asset(
      'assets/map_layers/westport-house/westport-house-floor-gf.geojson',
      shapeDataField: 'Musuem',
    );
    _zoomPanBehavior = MapZoomPanBehavior(minZoomLevel: 1.0);
   

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward(from: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfMaps(
          layers: [
            MapShapeLayer(
              zoomPanBehavior: _zoomPanBehavior,
              source: _mapSource,
              strokeColor: Colors.blue,
              initialMarkersCount: 2,
              markerBuilder: (BuildContext context, int index) {
                if (index != 0) {
                  return MapMarker(
                    latitude: coordinates[coordinates.length - 1].latitude,
                    longitude: coordinates[coordinates.length - 1].longitude,
                    child: Transform.translate(
                      offset: const Offset(0.0, -8.0),
                      child: const Icon(Icons.location_on, color: Colors.red, size: 30),
                    ),
                  );
                } else {
                  return MapMarker(
                    latitude: coordinates[0].latitude,
                    longitude: coordinates[0].longitude,
                    iconType: MapIconType.circle,
                    iconColor: Colors.white,
                    iconStrokeWidth: 2.0,
                    size: const Size(5.0, 5.0),
                    iconStrokeColor: Colors.black,
                  );
                } 
              },
              sublayers: [
                MapPolylineLayer(
                  color: Colors.red,
                  width: 5,
                  polylines: {
                    MapPolyline(
                      points: coordinates,
                    )
                  },
                  animation: _animation,
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}
