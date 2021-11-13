package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;

    public class AnimatedPetVisualizationData extends AnimatedFurnitureVisualizationData 
    {

        private var _commonAssets:IAssetLibrary = null;
        private var _isAllowedToTurnHead:Boolean = true;


        public function set commonAssets(_arg_1:IAssetLibrary):void
        {
            _commonAssets = _arg_1;
        }

        public function get commonAssets():IAssetLibrary
        {
            return (_commonAssets);
        }

        override protected function defineVisualizations(_arg_1:XML):Boolean
        {
            _isAllowedToTurnHead = ((_arg_1.graphics.hasOwnProperty("@disableheadturn")) ? (!(_arg_1.graphics.@disableheadturn == "1")) : true);
            return (super.defineVisualizations(_arg_1));
        }

        override protected function createSizeData(_arg_1:int, _arg_2:int, _arg_3:int):SizeData
        {
            var _local_4:SizeData;
            if (_arg_1 > 1)
            {
                _local_4 = new PetAnimationSizeData(_arg_2, _arg_3);
            }
            else
            {
                _local_4 = new AnimationSizeData(_arg_2, _arg_3);
            };
            return (_local_4);
        }

        override protected function processVisualizationElement(_arg_1:SizeData, _arg_2:XML):Boolean
        {
            var _local_3:PetAnimationSizeData;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            switch (String(_arg_2.name()))
            {
                case "postures":
                    _local_3 = (_arg_1 as PetAnimationSizeData);
                    if (_local_3 != null)
                    {
                        if (!_local_3.definePostures(_arg_2))
                        {
                            return (false);
                        };
                    };
                    break;
                case "gestures":
                    _local_3 = (_arg_1 as PetAnimationSizeData);
                    if (_local_3 != null)
                    {
                        if (!_local_3.defineGestures(_arg_2))
                        {
                            return (false);
                        };
                    };
                    break;
                default:
                    if (!super.processVisualizationElement(_arg_1, _arg_2))
                    {
                        return (false);
                    };
            };
            return (true);
        }

        public function getAnimationForPosture(_arg_1:int, _arg_2:String):int
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null)
            {
                return (_local_3.getAnimationForPosture(_arg_2));
            };
            return (-1);
        }

        public function getGestureDisabled(_arg_1:int, _arg_2:String):Boolean
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null)
            {
                return (_local_3.getGestureDisabled(_arg_2));
            };
            return (false);
        }

        public function getAnimationForGesture(_arg_1:int, _arg_2:String):int
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null)
            {
                return (_local_3.getAnimationForGesture(_arg_2));
            };
            return (-1);
        }

        public function getPostureForAnimation(_arg_1:int, _arg_2:int, _arg_3:Boolean):String
        {
            var _local_4:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_4 != null)
            {
                return (_local_4.getPostureForAnimation(_arg_2, _arg_3));
            };
            return (null);
        }

        public function getGestureForAnimation(_arg_1:int, _arg_2:int):String
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null)
            {
                return (_local_3.getGestureForAnimation(_arg_2));
            };
            return (null);
        }

        public function getGestureForAnimationId(_arg_1:int, _arg_2:int):String
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            return ((_local_3 == null) ? null : _local_3.getGestureForAnimationId(_arg_2));
        }

        public function getPostureCount(_arg_1:int):int
        {
            var _local_2:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_2 != null)
            {
                return (_local_2.getPostureCount());
            };
            return (0);
        }

        public function getGestureCount(_arg_1:int):int
        {
            var _local_2:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_2 != null)
            {
                return (_local_2.getGestureCount());
            };
            return (0);
        }

        public function get isAllowedToTurnHead():Boolean
        {
            return (_isAllowedToTurnHead);
        }


    }
}