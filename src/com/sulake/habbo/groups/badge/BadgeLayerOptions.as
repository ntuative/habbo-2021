package com.sulake.habbo.groups.badge
{
    public class BadgeLayerOptions 
    {

        private var _layerIndex:int = -1;
        private var _partIndex:int = -1;
        private var _colorIndex:int = -1;
        private var _gridX:int = -1;
        private var _gridY:int = -1;


        public function setGrid(_arg_1:int):void
        {
            _gridX = Math.floor((_arg_1 % 3));
            _gridY = Math.floor((_arg_1 / 3));
        }

        public function clone():BadgeLayerOptions
        {
            var _local_1:BadgeLayerOptions = new BadgeLayerOptions();
            _local_1._layerIndex = _layerIndex;
            _local_1._partIndex = _partIndex;
            _local_1._colorIndex = _colorIndex;
            _local_1._gridX = _gridX;
            _local_1._gridY = _gridY;
            return (_local_1);
        }

        public function equalVisuals(_arg_1:BadgeLayerOptions):Boolean
        {
            if (((((_arg_1 == null) || (!(_gridX == _arg_1.gridX))) || (!(_gridY == _arg_1.gridY))) || (!(_colorIndex == _arg_1.colorIndex))))
            {
                return (false);
            };
            if ((((_layerIndex == 0) && (!(_arg_1.layerIndex == 0))) || ((!(_layerIndex == 0)) && (_arg_1.layerIndex == 0))))
            {
                return (false);
            };
            return (true);
        }

        public function isGridEqual(_arg_1:BadgeLayerOptions):Boolean
        {
            if (((_arg_1.gridX == _gridX) && (_arg_1.gridY == _gridY)))
            {
                return (true);
            };
            return (false);
        }

        public function get layerIndex():int
        {
            return (_layerIndex);
        }

        public function set layerIndex(_arg_1:int):void
        {
            _layerIndex = _arg_1;
        }

        public function get partIndex():int
        {
            return (_partIndex);
        }

        public function set partIndex(_arg_1:int):void
        {
            _partIndex = _arg_1;
        }

        public function get colorIndex():int
        {
            return (_colorIndex);
        }

        public function set colorIndex(_arg_1:int):void
        {
            _colorIndex = _arg_1;
        }

        public function get gridX():int
        {
            return (_gridX);
        }

        public function set gridX(_arg_1:int):void
        {
            _gridX = _arg_1;
        }

        public function get gridY():int
        {
            return (_gridY);
        }

        public function set gridY(_arg_1:int):void
        {
            _gridY = _arg_1;
        }

        public function get position():int
        {
            return ((gridY * 3) + gridX);
        }


    }
}