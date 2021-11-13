package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;

    public class FurniturePlanetSystemVisualization extends AnimatedFurnitureVisualization 
    {

        private var _SafeStr_3352:Array;
        private var _SafeStr_3353:Array;
        private var _offsetArray:Array = [];
        private var _rootPosition:Vector3d = new Vector3d(0, 0, 0);


        override public function dispose():void
        {
            var _local_1:FurniturePlanetSystemVisualizationPlanetObject;
            if (_SafeStr_3352 != null)
            {
                while (_SafeStr_3352.length > 0)
                {
                    _local_1 = _SafeStr_3352.shift();
                    _local_1.dispose();
                };
            };
            _SafeStr_3352 = null;
            _SafeStr_3353 = null;
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            var _local_2:FurniturePlanetSystemVisualizationPlanetObject;
            var _local_3:int;
            if (((_SafeStr_3352 == null) && (spriteCount > 0)))
            {
                if (!readDefinition())
                {
                    return (0);
                };
            };
            if (_SafeStr_3352 != null)
            {
                _local_3 = 0;
                while (_local_3 < _SafeStr_3352.length)
                {
                    _local_2 = _SafeStr_3352[_local_3];
                    _local_2.update(_offsetArray, _rootPosition, _arg_1);
                    _local_3++;
                };
                return (super.updateAnimation(_arg_1));
            };
            return (0);
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_arg_3 < _offsetArray.length)
            {
                return (_offsetArray[_arg_3].x);
            };
            return (super.getSpriteXOffset(_arg_1, _arg_2, _arg_3));
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_arg_3 < _offsetArray.length)
            {
                return (_offsetArray[_arg_3].y);
            };
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3));
        }

        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            if (_arg_3 < _offsetArray.length)
            {
                return (_offsetArray[_arg_3].z);
            };
            return (super.getSpriteZOffset(_arg_1, _arg_2, _arg_3));
        }

        private function readDefinition():Boolean
        {
            var _local_4:IRoomObjectSprite;
            var _local_5:int;
            var _local_9:XML;
            var _local_2:IRoomObject = object;
            if (_local_2 == null)
            {
                return (false);
            };
            var _local_6:IRoomObjectModel = _local_2.getModel();
            if (_local_6 == null)
            {
                return (false);
            };
            var _local_8:String = _local_6.getString("furniture_planetsystem_data");
            var _local_7:XMLList = XMLList(_local_8);
            var _local_3:XMLList = _local_7.children();
            var _local_1:int = _local_3.length();
            _SafeStr_3352 = [];
            _SafeStr_3353 = [];
            _local_5 = 0;
            while (_local_5 < _local_1)
            {
                _local_9 = _local_3[_local_5];
                _local_4 = getSprite(_local_5);
                if (_local_4 != null)
                {
                    addPlanet(_local_9.@name, _local_5, _local_9.@parent, Number(_local_9.@radius), Number(_local_9.@arcspeed), Number(_local_9.@arcoffset), Number(_local_9.@height));
                };
                _local_5++;
            };
            return (true);
        }

        private function addPlanet(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):void
        {
            var _local_8:FurniturePlanetSystemVisualizationPlanetObject;
            if (_SafeStr_3352 == null)
            {
                return;
            };
            var _local_9:FurniturePlanetSystemVisualizationPlanetObject = new FurniturePlanetSystemVisualizationPlanetObject(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7);
            _local_8 = getPlanet(_arg_3);
            if (_local_8 != null)
            {
                _local_8.addChild(_local_9);
            }
            else
            {
                _SafeStr_3352.push(_local_9);
                _SafeStr_3353.push(_arg_1);
            };
        }

        private function getPlanet(_arg_1:String):FurniturePlanetSystemVisualizationPlanetObject
        {
            var _local_2:FurniturePlanetSystemVisualizationPlanetObject;
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _SafeStr_3352.length)
            {
                _local_2 = _SafeStr_3352[_local_3];
                if (_local_2.name == _arg_1)
                {
                    return (_local_2);
                };
                if (_local_2.hasChild(_arg_1))
                {
                    return (_local_2.getChild(_arg_1));
                };
                _local_3++;
            };
            return (null);
        }


    }
}

