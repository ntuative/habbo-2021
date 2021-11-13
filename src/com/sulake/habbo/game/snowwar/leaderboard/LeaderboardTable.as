package com.sulake.habbo.game.snowwar.leaderboard
{
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.communication.messages.parser.game.score.LeaderboardEntry;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetFriendsLeaderboardComposer;

    public class LeaderboardTable 
    {

        public static const SCROLL_DOWN:int = 0;
        public static const SCROLL_UP:int = 1;

        protected var _SafeStr_2499:SnowWarEngine;
        protected var _SafeStr_2512:Boolean;
        protected var _SafeStr_2513:int;
        protected var _SafeStr_2514:int = -1;
        protected var _disposed:Boolean;
        protected var _SafeStr_2515:Array;
        protected var _SafeStr_2516:int = -1;
        protected var _SafeStr_2517:int;
        protected var _SafeStr_2518:int = 8;
        protected var _SafeStr_2519:int = 50;
        protected var _SafeStr_2520:Boolean = true;
        protected var _SafeStr_2521:int;

        public function LeaderboardTable(_arg_1:SnowWarEngine)
        {
            _SafeStr_2499 = _arg_1;
            _SafeStr_2513 = _SafeStr_2499.sessionDataManager.userId;
            _SafeStr_2518 = _SafeStr_2499.config.getInteger("games.highscores.viewSize", 8);
            _SafeStr_2519 = _SafeStr_2499.config.getInteger("games.highscores.windowSize", 50);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            disposeTable();
            _SafeStr_2499 = null;
            _SafeStr_2515 = null;
            _disposed = true;
        }

        public function disposeTable():void
        {
            _SafeStr_2516 = -1;
            _SafeStr_2515 = null;
            _SafeStr_2517 = -1;
            _SafeStr_2520 = true;
        }

        public function addEntries(_arg_1:Array, _arg_2:int):void
        {
            _SafeStr_2517 = _arg_2;
            if (!_SafeStr_2515)
            {
                _SafeStr_2515 = _arg_1;
                initializeList();
            }
            else
            {
                _SafeStr_2515 = _arg_1;
                updateCurrentIndex();
            };
            _SafeStr_2520 = false;
        }

        public function addGroupEntries(_arg_1:Array, _arg_2:int, _arg_3:int):void
        {
            _SafeStr_2514 = _arg_3;
            _SafeStr_2517 = _arg_2;
            if (!_SafeStr_2515)
            {
                _SafeStr_2515 = _arg_1;
                initializeList();
            }
            else
            {
                _SafeStr_2515 = _arg_1;
                updateCurrentIndex();
            };
            _SafeStr_2520 = false;
        }

        protected function initializeList():void
        {
            var _local_3:int;
            var _local_1:Boolean;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2515.length)
            {
                _local_1 = ((_SafeStr_2515[_local_3] as LeaderboardEntry).gender == "g");
                if (((!(_local_1)) && ((_SafeStr_2515[_local_3] as LeaderboardEntry).userId == _SafeStr_2513)))
                {
                    _local_2 = _local_3;
                    break;
                };
                if (((_local_1) && ((_SafeStr_2515[_local_3] as LeaderboardEntry).userId == _SafeStr_2514)))
                {
                    _local_2 = _local_3;
                    break;
                };
                _local_3++;
            };
            if (_local_2 >= _SafeStr_2518)
            {
                _SafeStr_2516 = (_local_2 - (_SafeStr_2518 / 2));
            }
            else
            {
                _SafeStr_2516 = 0;
            };
        }

        private function updateCurrentIndex():void
        {
            if (_SafeStr_2516 < 0)
            {
                _SafeStr_2516 = (_SafeStr_2516 + _SafeStr_2519);
            }
            else
            {
                _SafeStr_2516 = (_SafeStr_2516 - _SafeStr_2519);
            };
        }

        public function isInitialized():Boolean
        {
            return (!(_SafeStr_2515 == null));
        }

        public function scrollUp():Boolean
        {
            var _local_2:int;
            var _local_1:IMessageComposer;
            if (_SafeStr_2520)
            {
                return (false);
            };
            _SafeStr_2516 = (_SafeStr_2516 - _SafeStr_2518);
            if (_SafeStr_2516 < 0)
            {
                if (_SafeStr_2515[0].rank > 1)
                {
                    _local_2 = Math.max(1, (_SafeStr_2515[0].rank - _SafeStr_2519));
                    _local_1 = getMessageComposer(_SafeStr_2521, _local_2, 1);
                    _SafeStr_2499.communication.connection.send(_local_1);
                    _SafeStr_2520 = true;
                    return (false);
                };
                _SafeStr_2516 = 0;
            };
            return (true);
        }

        protected function getMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int):IMessageComposer
        {
            return (new Game2GetFriendsLeaderboardComposer(_arg_1, _arg_2, _arg_3, _SafeStr_2518, _SafeStr_2519));
        }

        public function scrollDown():Boolean
        {
            var _local_2:int;
            var _local_1:IMessageComposer;
            if (_SafeStr_2520)
            {
                return (false);
            };
            _SafeStr_2516 = (_SafeStr_2516 + _SafeStr_2518);
            if ((_SafeStr_2516 + _SafeStr_2518) >= _SafeStr_2515.length)
            {
                if (_SafeStr_2515[(_SafeStr_2515.length - 1)].rank < _SafeStr_2517)
                {
                    _local_2 = (_SafeStr_2515[(_SafeStr_2515.length - 1)].rank + 1);
                    _local_1 = getMessageComposer(_SafeStr_2521, _local_2, 0);
                    _SafeStr_2499.communication.connection.send(_local_1);
                    _SafeStr_2520 = true;
                    return (false);
                };
            };
            return (true);
        }

        public function revertToDefaultView(_arg_1:int):void
        {
            disposeTable();
            var _local_2:IMessageComposer = getMessageComposer(_arg_1, -1, 0);
            _SafeStr_2499.communication.connection.send(_local_2);
            _SafeStr_2520 = true;
            _SafeStr_2521 = _arg_1;
        }

        public function getVisibleEntries():Array
        {
            var _local_2:int;
            var _local_1:Array = [];
            if (!_SafeStr_2515)
            {
                return (_local_1);
            };
            var _local_3:int = Math.min(_SafeStr_2515.length, (_SafeStr_2516 + _SafeStr_2518));
            _local_2 = _SafeStr_2516;
            while (_local_2 < _local_3)
            {
                _local_1.push(_SafeStr_2515[_local_2]);
                _local_2++;
            };
            return (_local_1);
        }

        public function canScrollUp():Boolean
        {
            if ((((_SafeStr_2520) || (!(_SafeStr_2515))) || (_SafeStr_2515.length == 0)))
            {
                return (false);
            };
            if (((_SafeStr_2515[0].rank == 1) && (_SafeStr_2516 <= 0)))
            {
                return (false);
            };
            return (true);
        }

        public function canScrollDown():Boolean
        {
            if ((((_SafeStr_2520) || (!(_SafeStr_2515))) || (_SafeStr_2515.length == 0)))
            {
                return (false);
            };
            if (((_SafeStr_2515[(_SafeStr_2515.length - 1)].rank >= _SafeStr_2517) && ((_SafeStr_2516 + _SafeStr_2518) >= _SafeStr_2515.length)))
            {
                return (false);
            };
            return (true);
        }

        public function get viewSize():int
        {
            return (_SafeStr_2518);
        }

        public function get favouriteGroupId():int
        {
            return (_SafeStr_2514);
        }


    }
}

