package com.sulake.habbo.room.object.visualization.room
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomVisualizationData implements IRoomObjectVisualizationData 
    {

        private var _wallRasterizer:WallRasterizer;
        private var _floorRasterizer:FloorRasterizer;
        private var _wallAdRasterizr:WallAdRasterizer;
        private var _landscapeRasterizer:LandscapeRasterizer;
        private var _maskManager:PlaneMaskManager;
        private var _initialized:Boolean = false;

        public function RoomVisualizationData()
        {
            _wallRasterizer = new WallRasterizer();
            _floorRasterizer = new FloorRasterizer();
            _wallAdRasterizr = new WallAdRasterizer();
            _landscapeRasterizer = new LandscapeRasterizer();
            _maskManager = new PlaneMaskManager();
        }

        public function get initialized():Boolean
        {
            return (_initialized);
        }

        public function get floorRasterizer():IPlaneRasterizer
        {
            return (_floorRasterizer);
        }

        public function get wallRasterizer():IPlaneRasterizer
        {
            return (_wallRasterizer);
        }

        public function get wallAdRasterizr():WallAdRasterizer
        {
            return (_wallAdRasterizr);
        }

        public function get landscapeRasterizer():IPlaneRasterizer
        {
            return (_landscapeRasterizer);
        }

        public function get maskManager():PlaneMaskManager
        {
            return (_maskManager);
        }

        public function dispose():void
        {
            if (_wallRasterizer != null)
            {
                _wallRasterizer.dispose();
                _wallRasterizer = null;
            };
            if (_floorRasterizer != null)
            {
                _floorRasterizer.dispose();
                _floorRasterizer = null;
            };
            if (_wallAdRasterizr != null)
            {
                _wallAdRasterizr.dispose();
                _wallAdRasterizr = null;
            };
            if (_landscapeRasterizer != null)
            {
                _landscapeRasterizer.dispose();
                _landscapeRasterizer = null;
            };
            if (_maskManager != null)
            {
                _maskManager.dispose();
                _maskManager = null;
            };
        }

        public function clearCache():void
        {
            if (_wallRasterizer != null)
            {
                _wallRasterizer.clearCache();
            };
            if (_floorRasterizer != null)
            {
                _floorRasterizer.clearCache();
            };
            if (_landscapeRasterizer != null)
            {
                _landscapeRasterizer.clearCache();
            };
        }

        public function initialize(_arg_1:XML):Boolean
        {
            var _local_4:XML;
            var _local_3:XML;
            var _local_7:XML;
            var _local_11:XML;
            var _local_6:XML;
            reset();
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_5:XMLList = _arg_1.wallData;
            if (_local_5.length() > 0)
            {
                _local_4 = _local_5[0];
                _wallRasterizer.initialize(_local_4);
            };
            var _local_2:XMLList = _arg_1.floorData;
            if (_local_2.length() > 0)
            {
                _local_3 = _local_2[0];
                _floorRasterizer.initialize(_local_3);
            };
            var _local_10:XMLList = _arg_1.wallAdData;
            if (_local_10.length() > 0)
            {
                _local_7 = _local_10[0];
                _wallAdRasterizr.initialize(_local_7);
            };
            var _local_8:XMLList = _arg_1.landscapeData;
            if (_local_8.length() > 0)
            {
                _local_11 = _local_8[0];
                _landscapeRasterizer.initialize(_local_11);
            };
            var _local_9:XMLList = _arg_1.maskData;
            if (_local_9.length() > 0)
            {
                _local_6 = _local_9[0];
                _maskManager.initialize(_local_6);
            };
            return (true);
        }

        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (_initialized)
            {
                return;
            };
            _wallRasterizer.initializeAssetCollection(_arg_1);
            _floorRasterizer.initializeAssetCollection(_arg_1);
            _wallAdRasterizr.initializeAssetCollection(_arg_1);
            _landscapeRasterizer.initializeAssetCollection(_arg_1);
            _maskManager.initializeAssetCollection(_arg_1);
            _initialized = true;
        }

        protected function reset():void
        {
        }


    }
}