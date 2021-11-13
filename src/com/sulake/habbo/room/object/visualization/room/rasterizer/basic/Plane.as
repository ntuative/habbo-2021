package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.IRoomGeometry;

    public class Plane 
    {

        private var _SafeStr_3428:Map;
        private var _SafeStr_3386:Array = [];
        private var _lastPlaneVisualization:PlaneVisualization = null;
        private var _SafeStr_3389:int = -1;

        public function Plane()
        {
            _SafeStr_3428 = new Map();
        }

        public function isStatic(_arg_1:int):Boolean
        {
            return (true);
        }

        public function dispose():void
        {
            var _local_1:PlaneVisualization;
            var _local_2:int;
            if (_SafeStr_3428 != null)
            {
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < _SafeStr_3428.length)
                {
                    _local_1 = (_SafeStr_3428.getWithIndex(_local_2) as PlaneVisualization);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3428.dispose();
                _SafeStr_3428 = null;
            };
            _lastPlaneVisualization = null;
            _SafeStr_3386 = null;
        }

        public function clearCache():void
        {
            var _local_2:int;
            var _local_1:PlaneVisualization;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3428.length)
            {
                _local_1 = (_SafeStr_3428.getWithIndex(_local_2) as PlaneVisualization);
                if (_local_1 != null)
                {
                    _local_1.clearCache();
                };
                _local_2++;
            };
        }

        public function createPlaneVisualization(_arg_1:int, _arg_2:int, _arg_3:IRoomGeometry):PlaneVisualization
        {
            if (_SafeStr_3428.getValue(String(_arg_1)) != null)
            {
                return (null);
            };
            var _local_4:PlaneVisualization = new PlaneVisualization(_arg_1, _arg_2, _arg_3);
            _SafeStr_3428.add(String(_arg_1), _local_4);
            _SafeStr_3386.push(_arg_1);
            _SafeStr_3386.sort();
            return (_local_4);
        }

        private function getSizeIndex(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int;
            _local_3 = 1;
            while (_local_3 < _SafeStr_3386.length)
            {
                if (_SafeStr_3386[_local_3] > _arg_1)
                {
                    if ((_SafeStr_3386[_local_3] - _arg_1) < (_arg_1 - _SafeStr_3386[(_local_3 - 1)]))
                    {
                        _local_2 = _local_3;
                    };
                    break;
                };
                _local_2 = _local_3;
                _local_3++;
            };
            return (_local_2);
        }

        protected function getPlaneVisualization(_arg_1:int):PlaneVisualization
        {
            if (_arg_1 == _SafeStr_3389)
            {
                return (_lastPlaneVisualization);
            };
            var _local_2:int = getSizeIndex(_arg_1);
            if (_local_2 < _SafeStr_3386.length)
            {
                _lastPlaneVisualization = (_SafeStr_3428.getValue(_SafeStr_3386[_local_2]) as PlaneVisualization);
            }
            else
            {
                _lastPlaneVisualization = null;
            };
            _SafeStr_3389 = _arg_1;
            return (_lastPlaneVisualization);
        }

        public function getLayers():Array
        {
            return (getPlaneVisualization(_SafeStr_3389).getLayers());
        }


    }
}

