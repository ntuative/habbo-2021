package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;
    import flash.utils.describeType;

        public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_1729:int = -1;
        public static const _SafeStr_1730:int = -2;
        public static const _SafeStr_1731:int = -3;
        public static const _SafeStr_1732:int = 0;
        public static const _SafeStr_1733:int = 1;
        public static const _SafeStr_1734:int = 2;
        public static const _SafeStr_1735:int = 3;
        public static const _SafeStr_1736:int = 4;
        public static const _SafeStr_1737:int = 5;
        public static const _SafeStr_1738:int = 10;
        public static const _SafeStr_1739:int = 11;
        public static const _SafeStr_1740:int = 12;
        public static const _SafeStr_1741:int = 13;
        public static const _SafeStr_1742:int = 16;
        public static const _SafeStr_1743:int = 17;
        public static const _SafeStr_1744:int = 18;
        public static const _SafeStr_1745:int = 19;
        public static const _SafeStr_1746:int = 20;
        public static const _SafeStr_1747:int = 22;
        public static const _SafeStr_1748:int = 23;
        public static const _SafeStr_1749:int = 24;
        public static const _SafeStr_1750:int = 25;
        public static const _SafeStr_1751:int = 26;
        public static const _SafeStr_1752:int = 27;
        public static const _SafeStr_1753:int = 28;
        public static const _SafeStr_1754:int = 29;
        public static const _SafeStr_1755:int = 100;
        public static const _SafeStr_1756:int = 101;
        public static const _SafeStr_1757:int = 102;
        public static const _SafeStr_1758:int = 103;
        public static const _SafeStr_1759:int = 104;
        public static const _SafeStr_1760:int = 105;
        public static const _SafeStr_1761:int = 106;
        public static const _SafeStr_1762:int = 107;
        public static const _SafeStr_1763:int = 108;
        public static const _SafeStr_1764:int = 109;
        public static const _SafeStr_1765:int = 110;
        public static const _SafeStr_1766:int = 111;
        public static const _SafeStr_1767:int = 112;
        public static const _SafeStr_1768:int = 113;
        public static const _SafeStr_1769:int = 114;
        public static const _SafeStr_1770:int = 115;
        public static const _SafeStr_1771:int = 116;
        public static const SOCKET_WRITE_EXCEPTION_1:int = 117;
        public static const SOCKET_WRITE_EXCEPTION_2:int = 118;
        public static const SOCKET_WRITE_EXCEPTION_3:int = 119;
        public static const _SafeStr_1772:int = 120;
        public static const _SafeStr_1773:int = 121;
        public static const _SafeStr_1774:int = 122;
        public static const _SafeStr_1775:int = 123;
        public static const _SafeStr_1776:int = 124;
        public static const _SafeStr_1777:int = 125;
        public static const _SafeStr_1778:int = 126;

        private static var _SafeStr_1779:Dictionary;

        public function DisconnectReasonEvent(_arg_1:Function)
        {
            super(_arg_1, DisconnectReasonParser);
        }

        public static function resolveDisconnectedReasonLocalizationKey(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case -2:
                    return ("${disconnected.maintenance}");
                case 0:
                    return ("${disconnected.logged_out}");
                case 1:
                    return ("${disconnected.just_banned}");
                case 10:
                    return ("${disconnected.still_banned}");
                case 2:
                case 13:
                case 11:
                case 18:
                    return ("${disconnected.concurrent_login}");
                case 12:
                case 19:
                    return ("${disconnected.hotel_closed}");
                case 20:
                    return ("${disconnected.incorrect_password}");
                case 112:
                    return ("${disconnected.idle}");
                case 122:
                    return ("${disconnected.incompatible_client_version}");
                case 4:
                case 5:
                case 16:
                case 17:
                case 22:
                case 23:
                case 24:
                case 25:
                case 26:
                case 27:
                case 28:
                case 29:
                case 100:
                case 101:
                case 102:
                case 103:
                case 104:
                case 105:
                case 106:
                case 107:
                case 108:
                case 109:
                case 110:
                case 111:
                case 113:
                case 114:
                case 115:
                case 116:
                case 117:
                case 118:
                case 119:
                case 120:
                case 121:
                case 123:
                case 124:
                case 125:
                case 126:
                    return ("${disconnected.generic}");
                default:
                    return ("${disconnected.generic}");
            };
        }


        public function get reason():int
        {
            return ((this._SafeStr_816 as DisconnectReasonParser).reason);
        }

        public function get reasonString():String
        {
            switch (reason)
            {
                case 1:
                case 10:
                    return ("banned");
                case 2:
                    return ("concurrentlogin");
                case 20:
                    return ("incorrectpassword");
                default:
                    return ("logout");
            };
        }

        public function getReasonName():String
        {
            var _local_2:XML;
            var _local_3:String;
            var _local_4:String;
            if (_SafeStr_1779 == null)
            {
                _SafeStr_1779 = new Dictionary();
                _local_2 = describeType(DisconnectReasonEvent);
                for each (var _local_1:XML in _local_2.constant)
                {
                    _local_3 = _local_1.@name;
                    _local_4 = DisconnectReasonEvent[_local_1.@name];
                    _SafeStr_1779[_local_4] = _local_3;
                };
            };
            return (_SafeStr_1779[reason]);
        }


    }
}

