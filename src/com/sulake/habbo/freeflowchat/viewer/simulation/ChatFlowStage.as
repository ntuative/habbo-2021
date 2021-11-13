package com.sulake.habbo.freeflowchat.viewer.simulation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import __AS3__.vec.Vector;
    import flash.geom.Point;
    import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;

    public class ChatFlowStage implements IDisposable, IUpdateReceiver 
    {

        public static const MOVE_UP_AMOUNT_PIXELS:int = 19;
        private static const CLEANUP_TIMER_DELAY:int = 5000;
        private static const MOVE_UP_TIMER_DEFAULT:int = 10000;
        private static const MAX_ITERATIONS:int = 20;
        private static const MAX_COLLISION_SIDEWAYS_IMPULSE:int = 15;
        private static const MOVE_UP_IMPULSE_LIMIT:Number = 8;

        private const MINIMUM_COLLIDER_WIDTH:int = 240;

        private var _SafeStr_659:HabboFreeFlowChat;
        private var _simulationTime:uint = 0;
        private var _SafeStr_2190:uint = 0;
        private var _SafeStr_2191:uint = 0;
        private var _SafeStr_2192:ChatFlowGravity = new ChatFlowGravity();
        private var _SafeStr_2193:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
        private var _toRemove:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
        private var _SafeStr_2194:Boolean = false;
        private var _SafeStr_2195:int = 10000;
        private var _SafeStr_2196:Boolean = true;
        private var _SafeStr_2197:Boolean = false;
        private var _SafeStr_2198:int = 0;

        public function ChatFlowStage(_arg_1:HabboFreeFlowChat)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_659.registerUpdateReceiver(this, 2);
            refreshSettings();
        }

        public function refreshSettings():void
        {
            if (_SafeStr_659.roomChatSettings)
            {
                _SafeStr_2194 = (_SafeStr_659.roomChatSettings.mode == 1);
                _SafeStr_2196 = (!(_SafeStr_2194));
                switch (_SafeStr_659.roomChatSettings.scrollSpeed)
                {
                    case 0:
                        _SafeStr_2195 = 3000;
                        return;
                    case 1:
                        _SafeStr_2195 = 6000;
                        return;
                    case 2:
                        _SafeStr_2195 = 12000;
                    default:
                };
            };
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_659)
                {
                    _SafeStr_659.removeUpdateReceiver(this);
                    _SafeStr_659 = null;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_659 == null);
        }

        public function insertBubble(_arg_1:PooledChatBubble):Point
        {
            var _local_11:ChatBubbleSimulationEntity;
            var _local_6:int;
            var _local_3:Number;
            var _local_5:Number;
            var _local_8:Number;
            var _local_2:ChatBubbleSimulationWithLimitedWideRect;
            var _local_10:int;
            if (_SafeStr_2198 == 0)
            {
                _SafeStr_2198 = _SafeStr_659.chatFlowViewer.viewBottom;
            };
            if (((!(_SafeStr_2194)) && (_arg_1.width < 240)))
            {
                _local_11 = new ChatBubbleSimulationWithLimitedWideRect(_arg_1);
            }
            else
            {
                _local_11 = new ChatBubbleSimulationEntity(_arg_1, _SafeStr_2194);
            };
            var _local_9:Point = new Point((_arg_1.userScreenPos.x - (_local_11.visualRect.width / 2)), _SafeStr_659.chatFlowViewer.viewBottom);
            var _local_4:Point = _SafeStr_659.roomEngine.getRoomCanvasScreenOffset(_arg_1.roomId);
            if (_local_4 != null)
            {
                _local_9.x = (_local_9.x - _local_4.x);
            };
            _local_9.y = (_local_9.y - ((_arg_1.overlap) ? _arg_1.overlap.y : 0));
            _local_9.x = (_local_9.x - ((_arg_1.overlap) ? _arg_1.overlap.x : 0));
            _local_11.initializePosition(_local_9.x, _local_9.y);
            if (((_SafeStr_2196) && (!(_SafeStr_2194))))
            {
                _local_6 = 0;
                while (_local_6 < (20 / 2))
                {
                    _local_3 = 0;
                    for each (var _local_7:ChatBubbleSimulationEntity in _SafeStr_2193)
                    {
                        _local_3 = (_local_3 + _SafeStr_2192.getAttraction(_local_11, _local_7, 60, 40));
                    };
                    _local_11.x = (_local_11.x + _local_3);
                    _local_6++;
                };
                _local_5 = _local_11.x;
                _local_10 = (_arg_1.userScreenPos.x - ((_local_4 != null) ? _local_4.x : 0));
                if (_local_11.x > (_local_10 - 15))
                {
                    _local_5 = (_local_10 - 15);
                    if (_local_11.hasWideRect)
                    {
                        _local_2 = ChatBubbleSimulationWithLimitedWideRect(_local_11);
                        _local_8 = (_local_11.x - _local_5);
                        _local_2.wideRectOffset = (_local_2.wideRectOffset + _local_8);
                        _local_2.wideRectOffset = Math.min(0, _local_2.wideRectOffset);
                    };
                }
                else
                {
                    if ((_local_11.x + _local_11.visualRect.width) < (_local_10 + 15))
                    {
                        _local_5 = ((_local_10 - _local_11.visualRect.width) + 15);
                        if (_local_11.hasWideRect)
                        {
                            _local_2 = ChatBubbleSimulationWithLimitedWideRect(_local_11);
                            _local_8 = (_local_11.x - _local_5);
                            _local_2.wideRectOffset = (_local_2.wideRectOffset + _local_8);
                            _local_2.wideRectOffset = Math.max(-(_local_2.wideRect.width - _local_2.visualRect.width), _local_2.wideRectOffset);
                        };
                    };
                };
                var _local_13:Number = _local_5;
                _local_9.x = _local_13;
                _local_11.x = _local_13;
            };
            _SafeStr_2193.push(_local_11);
            _local_9.x = (_local_9.x - ((_arg_1.overlap) ? _arg_1.overlap.x : 0));
            if (_SafeStr_2194)
            {
                _SafeStr_2190 = _simulationTime;
            };
            return (_local_9);
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:int;
            var _local_2:ChatBubbleSimulationEntity;
            _simulationTime = (_simulationTime + _arg_1);
            simulate();
            if ((_SafeStr_2190 + _SafeStr_2195) < _simulationTime)
            {
                scrollUp();
                _SafeStr_2190 = _simulationTime;
            };
            _local_3 = 0;
            while (_local_3 < _SafeStr_2193.length)
            {
                _local_2 = _SafeStr_2193[_local_3];
                _local_2.syncToVisualization();
                if (!_local_2.isSpacer)
                {
                    _local_2.fullHeightCollision = false;
                    if (((_local_3 > 0) && (_local_2.visualizationHasHitMargin)))
                    {
                        _local_2.fullHeightCollision = true;
                        _SafeStr_2193[(_local_3 - 1)].fullHeightCollision = true;
                    };
                };
                _local_3++;
            };
            if ((_SafeStr_2191 + 5000) < _simulationTime)
            {
                cleanup();
                _SafeStr_2191 = _simulationTime;
            };
        }

        public function clear():void
        {
            for each (var _local_1:ChatBubbleSimulationEntity in _SafeStr_2193)
            {
                _local_1.readyToRecycle = true;
            };
            update(0);
            _SafeStr_659.chatFlowViewer.update(0);
        }

        private function simulate():void
        {
            var _local_7:Vector.<ChatBubbleCollisionEvent> = undefined;
            var _local_2:ChatBubbleCollisionEvent;
            var _local_5:ChatBubbleSimulationEntity;
            var _local_11:ChatBubbleSimulationEntity;
            var _local_4:ChatBubbleSimulationEntity;
            var _local_9:int;
            var _local_6:int;
            var _local_1:Number;
            var _local_10:Number;
            var _local_3:Number;
            var _local_8:Number;
            _local_9 = 0;
            while (_local_9 < 20)
            {
                _local_7 = new Vector.<ChatBubbleCollisionEvent>(0);
                for each (_local_11 in _SafeStr_2193)
                {
                    _local_11.resetSimulationStep();
                    for each (_local_4 in _SafeStr_2193)
                    {
                        if (((!(_local_11 == _local_4)) && (_local_11.intersectsWith(_local_4))))
                        {
                            _local_7.push(new ChatBubbleCollisionEvent(_local_11, _local_4));
                        };
                    };
                };
                if (_local_7.length == 0) break;
                if (_SafeStr_2194)
                {
                    for each (_local_2 in _local_7)
                    {
                        if (((!(_local_2.first.hasCollidedWith(_local_2.second))) && (!(_local_2.second.hasCollidedWith(_local_2.first)))))
                        {
                            if (_local_2.areSameY)
                            {
                                _local_2.older.addVerticalImpulse(-(_local_2.older.wideRect.height));
                            }
                            else
                            {
                                _local_6 = ((_local_2.first.visualIntertersectsWith(_local_2.second)) ? _local_2.top.visualRect.bottom : _local_2.top.wideRect.bottom);
                                _local_2.top.addVerticalImpulse(-((_local_6 - _local_2.bottom.y) + 1));
                            };
                        };
                        _local_2.first.addCollisionHandled(_local_2.second);
                        _local_2.second.addCollisionHandled(_local_2.first);
                    };
                }
                else
                {
                    for each (_local_2 in _local_7)
                    {
                        if (((!(_local_2.first.hasCollidedWith(_local_2.second))) && (!(_local_2.second.hasCollidedWith(_local_2.first)))))
                        {
                            _local_1 = ((_local_2.left is ChatBubbleSimulationWithLimitedWideRect) ? (ChatBubbleSimulationWithLimitedWideRect(_local_2.left).wideRectOffset + _local_2.left.x) : _local_2.left.x);
                            _local_10 = ((_local_2.right is ChatBubbleSimulationWithLimitedWideRect) ? (ChatBubbleSimulationWithLimitedWideRect(_local_2.right).wideRectOffset + _local_2.right.x) : _local_2.right.x);
                            _local_3 = ((_local_2.left is ChatBubbleSimulationWithLimitedWideRect) ? _local_2.left.wideRect.width : _local_2.left.visualRect.width);
                            _local_8 = (Math.abs(((_local_1 + _local_3) - _local_10)) / 2);
                            if (_local_8 <= 15)
                            {
                                _local_2.left.addHorizontalImpulse(-(_local_8));
                                _local_2.right.addHorizontalImpulse((_local_8 + 1));
                            }
                            else
                            {
                                if (_local_2.areSameY)
                                {
                                    _local_2.older.addVerticalImpulse(-(_local_2.older.visualRect.height));
                                }
                                else
                                {
                                    _local_2.top.addVerticalImpulse(-((_local_2.top.visualRect.bottom - _local_2.bottom.y) + 1));
                                };
                            };
                            _local_2.first.addCollisionHandled(_local_2.second);
                            _local_2.second.addCollisionHandled(_local_2.first);
                        };
                    };
                };
                for each (_local_5 in _SafeStr_2193)
                {
                    _local_5.applyImpulseForces(8);
                };
                _local_9++;
            };
        }

        private function scrollUp():void
        {
            if (_SafeStr_659.chatFlowViewer == null)
            {
                return;
            };
            for each (var _local_1:ChatBubbleSimulationEntity in _SafeStr_2193)
            {
                if (_SafeStr_2196)
                {
                    for each (var _local_2:ChatBubbleSimulationEntity in _SafeStr_2193)
                    {
                        if (_local_1 != _local_2)
                        {
                            _local_1.x = (_local_1.x + _SafeStr_2192.getAttraction(_local_1, _local_2));
                        };
                    };
                };
                _local_1.y = (_local_1.y - 19);
            };
            if (_SafeStr_2194)
            {
                insertBubble(_SafeStr_659.chatBubbleFactory.getNewEmptySpace(19));
                _SafeStr_2193[(_SafeStr_2193.length - 1)].fullHeightCollision = true;
                _SafeStr_2193[(_SafeStr_2193.length - 1)].isSpacer = true;
            };
            simulate();
        }

        private function cleanup():void
        {
            var _local_3:int;
            for each (var _local_1:ChatBubbleSimulationEntity in _SafeStr_2193)
            {
                if (((_local_1.visualRect.bottom < -10) || (_local_1.readyToRecycle)))
                {
                    _local_1.readyToRecycle = true;
                    if (_toRemove.indexOf(_local_1) == -1)
                    {
                        _toRemove.push(_local_1);
                    };
                };
            };
            if (_toRemove.length > 0)
            {
                for each (var _local_2:ChatBubbleSimulationEntity in _toRemove)
                {
                    _local_3 = _SafeStr_2193.indexOf(_local_2);
                    _local_2.dispose();
                    _SafeStr_2193.splice(_local_3, 1);
                };
                _toRemove = new Vector.<ChatBubbleSimulationEntity>(0);
            };
        }

        public function resize(_arg_1:int, _arg_2:int):void
        {
            var _local_3:ChatBubbleSimulationEntity;
            var _local_4:int;
            var _local_6:int;
            if (!_SafeStr_659)
            {
                return;
            };
            if (!_SafeStr_659.chatFlowViewer)
            {
                return;
            };
            var _local_5:int = _SafeStr_659.chatFlowViewer.viewBottom;
            if (_SafeStr_2198 != _local_5)
            {
                if (_SafeStr_2198 < _local_5)
                {
                    _local_4 = (_local_5 - _SafeStr_2198);
                    for each (_local_3 in _SafeStr_2193)
                    {
                        _local_3.y = (_local_3.y + _local_4);
                        _local_3.syncToVisualization(true);
                    };
                }
                else
                {
                    _local_6 = (_SafeStr_2198 - _local_5);
                    for each (_local_3 in _SafeStr_2193)
                    {
                        _local_3.y = (_local_3.y - _local_6);
                        _local_3.syncToVisualization(true);
                    };
                };
            };
            _SafeStr_2198 = _local_5;
        }


    }
}

