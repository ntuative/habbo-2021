package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.visualization.data.AnimationData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;

    public class AnimatedFurnitureVisualization extends FurnitureVisualization 
    {

        public static const DEFAULT_ANIMATION_ID:int = 0;

        private var _SafeStr_1403:AnimatedFurnitureVisualizationData = null;
        private var _SafeStr_448:int = -1;
        private var _SafeStr_3291:AnimationStateData;
        private var _animationChangeTime:int = 0;
        private var _frameIncrease:int = 1;
        private var _SafeStr_3292:Number = 0;
        private var _animatedLayerCount:int = 0;
        private var _SafeStr_3293:Boolean = false;

        public function AnimatedFurnitureVisualization()
        {
            _SafeStr_3291 = new AnimationStateData();
        }

        protected function get animatedLayerCount():int
        {
            return (_animatedLayerCount);
        }

        protected function get frameIncrease():int
        {
            return (_frameIncrease);
        }

        override protected function set direction(_arg_1:int):void
        {
            if (super.direction != _arg_1)
            {
                super.direction = _arg_1;
                _SafeStr_3293 = true;
            };
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_1403 = null;
            if (_SafeStr_3291 != null)
            {
                _SafeStr_3291.dispose();
                _SafeStr_3291 = null;
            };
        }

        public function get animationId():int
        {
            return (_SafeStr_3291.animationId);
        }

        protected function getAnimationId(_arg_1:AnimationStateData):int
        {
            var _local_2:int = animationId;
            if (((!(_local_2 == 0)) && (_SafeStr_1403.hasAnimation(_SafeStr_3292, _local_2))))
            {
                return (_local_2);
            };
            return (0);
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            if (!(_arg_1 is AnimatedFurnitureVisualizationData))
            {
                return (false);
            };
            _SafeStr_1403 = (_arg_1 as AnimatedFurnitureVisualizationData);
            return (super.initialize(_arg_1));
        }

        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:IRoomObject;
            var _local_6:int;
            var _local_4:IRoomObjectModel;
            var _local_5:int;
            if (super.updateObject(_arg_1, _arg_2))
            {
                _local_3 = object;
                if (_local_3 == null)
                {
                    return (false);
                };
                _local_6 = _local_3.getState(0);
                if (_local_6 != _SafeStr_448)
                {
                    setAnimation(_local_6);
                    _SafeStr_448 = _local_6;
                    _local_4 = _local_3.getModel();
                    if (_local_4 != null)
                    {
                        _local_5 = _local_4.getNumber("furniture_state_update_time");
                        _animationChangeTime = _local_5;
                    };
                };
                return (true);
            };
            return (false);
        }

        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_2:IRoomObject;
            var _local_4:IRoomObjectModel;
            var _local_5:int;
            var _local_3:Number;
            var _local_6:int;
            if (super.updateModel(_arg_1))
            {
                _local_2 = object;
                if (_local_2 != null)
                {
                    _local_4 = _local_2.getModel();
                    if (_local_4 != null)
                    {
                        if (usesAnimationResetting())
                        {
                            _local_5 = _local_4.getNumber("furniture_state_update_time");
                            if (_local_5 > _animationChangeTime)
                            {
                                _animationChangeTime = _local_5;
                                setAnimation(_SafeStr_448);
                            };
                        };
                        _local_3 = _local_4.getNumber("furniture_automatic_state_index");
                        if (!isNaN(_local_3))
                        {
                            _local_6 = _SafeStr_1403.getAnimationId(_SafeStr_3292, _local_3);
                            setAnimation(_local_6);
                        };
                    };
                };
                return (true);
            };
            return (false);
        }

        private function isPlayingTransition(_arg_1:AnimationStateData, _arg_2:int):Boolean
        {
            var _local_3:int = _arg_1.animationId;
            if (((AnimationData.isTransitionFromAnimation(_local_3)) || (AnimationData.isTransitionToAnimation(_local_3))))
            {
                if (_arg_2 == _arg_1.animationAfterTransitionId)
                {
                    if (!_arg_1.animationOver)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        private function getCurrentState(_arg_1:AnimationStateData):int
        {
            var _local_2:int = _arg_1.animationId;
            if (((AnimationData.isTransitionFromAnimation(_local_2)) || (AnimationData.isTransitionToAnimation(_local_2))))
            {
                return (_arg_1.animationAfterTransitionId);
            };
            return (_local_2);
        }

        protected function setAnimation(_arg_1:int):void
        {
            if (_SafeStr_1403 != null)
            {
                setSubAnimation(_SafeStr_3291, _arg_1, (_SafeStr_448 >= 0));
            };
        }

        protected function setSubAnimation(_arg_1:AnimationStateData, _arg_2:int, _arg_3:Boolean=true):Boolean
        {
            var _local_5:int;
            var _local_6:int;
            var _local_4:int = _arg_1.animationId;
            if (_arg_3)
            {
                if (isPlayingTransition(_arg_1, _arg_2))
                {
                    return (false);
                };
                _local_5 = getCurrentState(_arg_1);
                if (_arg_2 != _local_5)
                {
                    if (!_SafeStr_1403.isImmediateChange(_SafeStr_3292, _arg_2, _local_5))
                    {
                        _local_6 = AnimationData.getTransitionFromAnimationId(_local_5);
                        if (_SafeStr_1403.hasAnimation(_SafeStr_3292, _local_6))
                        {
                            _arg_1.animationAfterTransitionId = _arg_2;
                            _arg_2 = _local_6;
                        }
                        else
                        {
                            _local_6 = AnimationData.getTransitionToAnimationId(_arg_2);
                            if (_SafeStr_1403.hasAnimation(_SafeStr_3292, _local_6))
                            {
                                _arg_1.animationAfterTransitionId = _arg_2;
                                _arg_2 = _local_6;
                            };
                        };
                    };
                }
                else
                {
                    if (AnimationData.isTransitionFromAnimation(_local_4))
                    {
                        _local_6 = AnimationData.getTransitionToAnimationId(_arg_2);
                        if (_SafeStr_1403.hasAnimation(_SafeStr_3292, _local_6))
                        {
                            _arg_1.animationAfterTransitionId = _arg_2;
                            _arg_2 = _local_6;
                        };
                    }
                    else
                    {
                        if (!AnimationData.isTransitionToAnimation(_local_4))
                        {
                            if (usesAnimationResetting())
                            {
                                _local_6 = AnimationData.getTransitionFromAnimationId(_local_5);
                                if (_SafeStr_1403.hasAnimation(_SafeStr_3292, _local_6))
                                {
                                    _arg_1.animationAfterTransitionId = _arg_2;
                                    _arg_2 = _local_6;
                                }
                                else
                                {
                                    _local_6 = AnimationData.getTransitionToAnimationId(_arg_2);
                                    if (_SafeStr_1403.hasAnimation(_SafeStr_3292, _local_6))
                                    {
                                        _arg_1.animationAfterTransitionId = _arg_2;
                                        _arg_2 = _local_6;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (_local_4 != _arg_2)
            {
                _arg_1.animationId = _arg_2;
                return (true);
            };
            return (false);
        }

        protected function getLastFramePlayed(_arg_1:int):Boolean
        {
            return (_SafeStr_3291.getLastFramePlayed(_arg_1));
        }

        protected function resetAllAnimationFrames():void
        {
            if (_SafeStr_3291 != null)
            {
                _SafeStr_3291.setLayerCount(_animatedLayerCount);
            };
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            if (_SafeStr_1403 == null)
            {
                return (0);
            };
            if (_arg_1 != _SafeStr_3292)
            {
                _SafeStr_3292 = _arg_1;
                _animatedLayerCount = _SafeStr_1403.getLayerCount(_arg_1);
                resetAllAnimationFrames();
            };
            var _local_2:int = updateAnimations(_arg_1);
            _SafeStr_3293 = false;
            return (_local_2);
        }

        protected function updateAnimations(_arg_1:Number):int
        {
            var _local_2:int;
            if (((!(_SafeStr_3291.animationOver)) || (_SafeStr_3293)))
            {
                _local_2 = updateFramesForAnimation(_SafeStr_3291, _arg_1);
                if (_SafeStr_3291.animationOver)
                {
                    if (((AnimationData.isTransitionFromAnimation(_SafeStr_3291.animationId)) || (AnimationData.isTransitionToAnimation(_SafeStr_3291.animationId))))
                    {
                        setAnimation(_SafeStr_3291.animationAfterTransitionId);
                        _SafeStr_3291.animationOver = false;
                    };
                };
            };
            return (_local_2);
        }

        protected function updateFramesForAnimation(_arg_1:AnimationStateData, _arg_2:Number):int
        {
            var _local_7:int;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_11:AnimationFrame;
            var _local_3:int;
            if (((_arg_1.animationOver) && (!(_SafeStr_3293))))
            {
                return (0);
            };
            var _local_4:int = _arg_1.frameCounter;
            var _local_8:int = getAnimationId(_arg_1);
            if (_local_4 == 0)
            {
                _local_4 = _SafeStr_1403.getStartFrame(_arg_2, _local_8, direction);
            };
            _local_4 = (_local_4 + frameIncrease);
            _arg_1.frameCounter = _local_4;
            var _local_9:int;
            _arg_1.animationOver = true;
            var _local_10:int = (1 << (_animatedLayerCount - 1));
            _local_7 = (_animatedLayerCount - 1);
            while (_local_7 >= 0)
            {
                _local_5 = _arg_1.getAnimationPlayed(_local_7);
                if (((!(_local_5)) || (_SafeStr_3293)))
                {
                    _local_6 = _arg_1.getLastFramePlayed(_local_7);
                    _local_11 = _arg_1.getFrame(_local_7);
                    if (_local_11 != null)
                    {
                        if (((_local_11.isLastFrame) && (_local_11.remainingFrameRepeats <= frameIncrease)))
                        {
                            _local_6 = true;
                        };
                    };
                    if ((((_SafeStr_3293) || (_local_11 == null)) || ((_local_11.remainingFrameRepeats >= 0) && ((_local_11.remainingFrameRepeats = (_local_11.remainingFrameRepeats - frameIncrease)) <= 0))))
                    {
                        _local_3 = -1;
                        if (_local_11 != null)
                        {
                            _local_3 = _local_11.activeSequence;
                        };
                        if (_local_3 == -1)
                        {
                            _local_11 = _SafeStr_1403.getFrame(_arg_2, _local_8, direction, _local_7, _local_4);
                        }
                        else
                        {
                            _local_11 = _SafeStr_1403.getFrameFromSequence(_arg_2, _local_8, direction, _local_7, _local_3, (_local_11.activeSequenceOffset + _local_11.repeats), _local_4);
                        };
                        _arg_1.setFrame(_local_7, _local_11);
                        _local_9 = (_local_9 | _local_10);
                    };
                    if (((_local_11 == null) || (_local_11.remainingFrameRepeats == -1)))
                    {
                        _local_6 = true;
                        _local_5 = true;
                    }
                    else
                    {
                        _arg_1.animationOver = false;
                    };
                    _arg_1.setLastFramePlayed(_local_7, _local_6);
                    _arg_1.setAnimationPlayed(_local_7, _local_5);
                };
                _local_10 = (_local_10 >> 1);
                _local_7--;
            };
            return (_local_9);
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_3:AnimationFrame = _SafeStr_3291.getFrame(_arg_2);
            if (_local_3 != null)
            {
                return (_local_3.id);
            };
            return (super.getFrameNumber(_arg_1, _arg_2));
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int = super.getSpriteXOffset(_arg_1, _arg_2, _arg_3);
            var _local_5:AnimationFrame = _SafeStr_3291.getFrame(_arg_3);
            if (_local_5 != null)
            {
                _local_4 = (_local_4 + _local_5.x);
            };
            return (_local_4);
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int = super.getSpriteYOffset(_arg_1, _arg_2, _arg_3);
            var _local_5:AnimationFrame = _SafeStr_3291.getFrame(_arg_3);
            if (_local_5 != null)
            {
                _local_4 = (_local_4 + _local_5.y);
            };
            return (_local_4);
        }

        protected function usesAnimationResetting():Boolean
        {
            return (false);
        }


    }
}

