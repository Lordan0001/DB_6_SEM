using System;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
public class Route : INullable, IBinarySerialize
{
    private string _value;

    public string Value
    {
        get { return _value; }
        set { _value = value; }
    }

    public override string ToString()
    {
        return _value;
    }

    public bool IsNull
    {
        get { return string.IsNullOrEmpty(_value); }
    }

    public static Route Null
    {
        get
        {
            Route obj = new Route();
            obj._value = "";
            return obj;
        }
    }

    public void Read(System.IO.BinaryReader r)
    {
        _value = r.ReadString();
    }

    public void Write(System.IO.BinaryWriter w)
    {
        w.Write(_value);
    }

    [SqlMethod(OnNullCall = false)]
    public static Route Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;

        string value = s.Value.Replace(".", " ");
        return new Route() { _value = value };
    }
}
