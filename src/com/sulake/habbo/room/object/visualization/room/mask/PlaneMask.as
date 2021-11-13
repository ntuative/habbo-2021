package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.utils.IVector3d;

    public class PlaneMask 
    {

        private var _SafeStr_3424:Map;
        private var _SafeStr_3386:Array = [];
        private var _SafeStr_3372:Map;
        private var _lastMaskVisualization:PlaneMaskVisualization = null;
        private var _SafeStr_3389:int = -1;

        public function PlaneMask()
        {
            _SafeStr_3424 = new Map();
            _SafeStr_3372 = new Map();
        }

        public function dispose():void
        {
            var _local_2:PlaneMaskVisualization;
            var _local_1:int;
            if (_SafeStr_3424 != null)
            {
                _local_2 = null;
                _local_1 = 0;
                while (_local_1 < _SafeStr_3424.length)
                {
                    _local_2 = (_SafeStr_3424.getWithIndex(_local_1) as PlaneMaskVisualization);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                _SafeStr_3424.dispose();
                _SafeStr_3424 = null;
            };
            _lastMaskVisualization = null;
            _SafeStr_3386 = null;
        }

        public function createMaskVisualization(_arg_1:int):PlaneMaskVisualization
        {
            if (_SafeStr_3424.getValue(String(_arg_1)) != null)
            {
                return (null);
            };
            var _local_2:PlaneMaskVisualization = new PlaneMaskVisualization();
            _SafeStr_3424.add(String(_arg_1), _local_2);
            _SafeStr_3386.push(_arg_1);
            _SafeStr_3386.sort();
            return (_local_2);
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

        protected function getMaskVisualization(_arg_1:int):PlaneMaskVisualization
        {
            if (_arg_1 == _SafeStr_3389)
            {
                return (_lastMaskVisualization);
            };
            var _local_2:int = getSizeIndex(_arg_1);
            if (_local_2 < _SafeStr_3386.length)
            {
                _lastMaskVisualization = (_SafeStr_3424.getValue(_SafeStr_3386[_local_2]) as PlaneMaskVisualization);
            }
            else
            {
                _lastMaskVisualization = null;
            };
            _SafeStr_3389 = _arg_1;
            return (_lastMaskVisualization);
        }

        public function getGraphicAsset(_arg_1:Number, _arg_2:IVector3d):IGraphicAsset
        {
            var _local_3:PlaneMaskVisualization = getMaskVisualization(_arg_1);
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_4:IGraphicAsset = _local_3.getAsset(_arg_2);
            return (_local_4);
        }

        public function getAssetName(_arg_1:int):String
        {
            return (_SafeStr_3372.getValue(_arg_1));
        }

        public function setAssetName(_arg_1:int, _arg_2:String):void
        {
            _SafeStr_3372.add(_arg_1, _arg_2);
        }


    }
}

