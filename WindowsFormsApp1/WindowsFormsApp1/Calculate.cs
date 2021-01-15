using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace WindowsFormsApp1
{
    class Calculate
    {
        double Value;

        TinhTienLuongEntities data = new TinhTienLuongEntities();
        private static String[] lstWorkingHoursOfStaff = { "AtWorks", "WorkingDays", "WFHDays", "OFFDays", "LeaveHours" };
        private static String[] lstType = { "PC_", "BH_TH_", "OTH_" };
        public enum OperatorType { MULTIPLY, DIVIDE, ADD, SUBTRACT, EXPONENTIAL, OPAREN, CPAREN };
        public double VALUE
        {
            get { return this.Value; }
        }
        public double CALCULATE(string[] formula, int ID_NhanVien, DateTime date)
        {
            Parse p = new Parse(formula, ID_NhanVien, date);
            List<Element> e = p.PARSE;

            InfixToPostfix i = new InfixToPostfix();
            e = i.ConvertFromInfixToPostFix(e);

            PostFixEvaluator pfe = new PostFixEvaluator();
            if (e.Count == 2 && (e[1].ToString() == "+" || e[1].ToString() == "-"))
            {
                this.Value = (double)Double.Parse(formula[0]);
            }
            else
            {
                this.Value = pfe.Evaluate(e);
            }
            return Value;
        }
        public interface Element
        {
        }
        public class NumberElement : Element
        {
            double number;
            public Double getNumber()
            {
                return number;
            }

            public NumberElement(String number)
            {
                this.number = Double.Parse(number);
            }

            public override String ToString()
            {
                return ((int)number).ToString();
            }
        }
        public class OperatorElement : Element
        {
            public OperatorType type;
            char c;
            public OperatorElement(char op)
            {
                c = op;
                if (op == '+')
                    type = OperatorType.ADD;
                else if (op == '-')
                    type = OperatorType.SUBTRACT;
                else if (op == '*')
                    type = OperatorType.MULTIPLY;
                else if (op == '/')
                    type = OperatorType.DIVIDE;
                else if (op == '^')
                    type = OperatorType.EXPONENTIAL;
                else if (op == '(')
                    type = OperatorType.OPAREN;
                else if (op == ')')
                    type = OperatorType.CPAREN;
            }

            public override String ToString()
            {
                return c.ToString();
            }
        }
        public class FormulaConditionElement : Element
        {
            String formulaCondition;
            public FormulaConditionElement(string s)
            {
                this.formulaCondition = s;
            }
            public override string ToString()
            {
                return formulaCondition;
            }
        }
        public class InfixToPostfix
        {
            List<Element> converted = new List<Element>();
            int Precedence(OperatorElement c)
            {
                if (c.type == OperatorType.EXPONENTIAL)
                    return 2;
                else if (c.type == OperatorType.MULTIPLY || c.type == OperatorType.DIVIDE)
                    return 3;
                else if (c.type == OperatorType.ADD || c.type == OperatorType.SUBTRACT)
                    return 4;
                else
                    return Int32.MaxValue;
            }

            public void ProcessOperators(Stack<Element> st, Element element, Element top)
            {
                while (st.Count > 0 && Precedence((OperatorElement)element) >= Precedence((OperatorElement)top))
                {
                    Element p = st.Pop();
                    if (((OperatorElement)p).type == OperatorType.OPAREN)
                        break;
                    converted.Add(p);
                    if (st.Count > 0)
                        top = st.First();
                }
            }
            public List<Element> ConvertFromInfixToPostFix(List<Element> e)
            {
                List<Element> stack1 = new List<Element>(e);
                Stack<Element> st = new Stack<Element>();
                for (int i = 0; i < stack1.Count; i++)
                {
                    Element element = stack1[i];
                    if (element.GetType().Equals(typeof(OperatorElement)))
                    {
                        if (st.Count == 0 || ((OperatorElement)element).type == OperatorType.OPAREN)
                            st.Push(element);
                        else
                        {
                            Element top = st.First();
                            if (((OperatorElement)element).type == OperatorType.CPAREN)
                                ProcessOperators(st, element, top);
                            else if (Precedence((OperatorElement)element) < Precedence((OperatorElement)top))
                                st.Push(element);
                            else
                            {
                                ProcessOperators(st, element, top);
                                st.Push(element);
                            }
                        }
                    }
                    else
                        converted.Add(element);
                }

                //pop all operators in stack
                while (st.Count > 0)
                {
                    Element b1 = st.Pop();
                    converted.Add(b1);
                }

                return converted;
            }

            public override String ToString()
            {
                StringBuilder s = new StringBuilder();
                for (int j = 0; j < converted.Count; j++)
                    s.Append(converted[j].ToString() + " ");
                return s.ToString();
            }
        }
        public class PostFixEvaluator
        {
            Stack<Element> stack = new Stack<Element>();

            NumberElement calculate(NumberElement left, NumberElement right, OperatorElement op)
            {
                Double temp = Double.MaxValue;
                if (op.type == OperatorType.ADD)
                    temp = left.getNumber() + right.getNumber();
                else if (op.type == OperatorType.SUBTRACT)
                    temp = left.getNumber() - right.getNumber();
                else if (op.type == OperatorType.MULTIPLY)
                    temp = left.getNumber() * right.getNumber();
                else if (op.type == OperatorType.DIVIDE)
                    temp = left.getNumber() / right.getNumber();
                else if (op.type == OperatorType.EXPONENTIAL)
                    temp = Math.Pow(left.getNumber(), right.getNumber());

                return new NumberElement(temp.ToString());
            }
            public Double Evaluate(List<Element> e)
            {
                List<Element> v = new List<Element>(e);
                for (int i = 0; i < v.Count; i++)
                {
                    Element element = v[i];
                    if (element.GetType().Equals(typeof(NumberElement)))
                        stack.Push(element);
                    if (element.GetType().Equals(typeof(OperatorElement)))
                    {
                        NumberElement right = (NumberElement)stack.Pop();
                        NumberElement left = (NumberElement)stack.Pop();
                        NumberElement result = calculate(left, right, (OperatorElement)element);
                        stack.Push(result);
                    }
                }
                return ((NumberElement)stack.Pop()).getNumber();
            }
        }
        public class Parse
        {
            int ID_NhanVien;
            DateTime date;
            List<Element> e = new List<Element>();
            TinhTienLuongEntities data = new TinhTienLuongEntities();
            public Parse(string[] formulaBeforeParse, int ID_NhanVien, DateTime date)
            {
                this.ID_NhanVien = ID_NhanVien;
                this.date = date;
                string s = convertStringFormula(formulaBeforeParse);
                string tmp = "";
                string conditionformula = "";
                bool flag = false;
                int countCPAREN = 0;
                for (int i = 0; i < s.Length; i++)
                {
                    char c = s[i];
                    if ((Char.IsDigit(c) || c == '.') && flag == false)
                    {
                        tmp += c;
                        if (i == s.Length - 1)
                        {
                            e.Add(new NumberElement(tmp));
                        }
                    }
                    if ((i + 1 < s.Length) && flag == false)
                    {
                        char d = s[i + 1];
                        if (Char.IsDigit(d) == false && d != '.' && tmp.Length > 0)
                        {
                            e.Add(new NumberElement(tmp));
                            tmp = "";
                        }
                    }
                    if ((c == '+' || c == '-' || c == '*' || c == '/' || c == '^' || c == '(' || c == ')') && flag == false)
                    {
                        e.Add(new OperatorElement(c));
                        continue;
                    }
                    if ((c == 'I' || c == 'i') && (s[i + 1] == 'f' || s[i + 1] == 'F'))
                    {
                        flag = true;
                        conditionformula += c;
                        continue;
                    }
                    if (flag == true)
                    {
                        conditionformula += c;
                    }
                    if (c == ')' && flag == true)
                    {
                        countCPAREN--;
                    }
                    if (c == '(' && flag == true)
                    {
                        countCPAREN++;
                    }
                    if (c == ')' && flag == true && countCPAREN == 0)
                    {
                        flag = false;
                        e.Add(new FormulaConditionElement(conditionformula));
                        continue;
                    }
                }

                int count = 0;
                foreach (var element in e.ToList())
                {
                    if (element.GetType() == typeof(FormulaConditionElement))
                    {
                        string[] a = ParseStringCondition(element.ToString());
                        e.RemoveAt(count);
                        string num = ifRecursive(a[1], a[3], a[5]);
                        e.Insert(count, new NumberElement(num));
                    }
                    count++;
                }
            }
            public List<Element> PARSE
            {
                get { return this.e; }
            }
            public string ifRecursive(string condition, string trueValue, string falseValue)
            {
                if (Compare2Value(condition))
                {
       
                    Calculate value = new Calculate();
                    return value.CALCULATE(StringToArrayByOp(trueValue), ID_NhanVien, date).ToString();
                }
                else if (falseValue.Contains('>') || falseValue.Contains('<') || falseValue.Contains('='))
                {
                    string[] tmp = ParseStringCondition(falseValue);
                    return ifRecursive(tmp[1], tmp[3], tmp[5]);
                }
                else
                {
                    Calculate value = new Calculate();
                    return value.CALCULATE(StringToArrayByOp(falseValue), ID_NhanVien, date).ToString();
                }
            }
            private string[] StringToArrayByOp(string str)
            {
                List<String> lst = new List<string>();
                string tmp = "";
                foreach (char c in str)
                {
                    if (c == '+' || c == '-' || c == '*' || c == '/' || c == '(' || c == ')')
                    {
                        lst.Add(tmp);
                        lst.Add(c.ToString());
                        tmp = "";
                        continue;
                    }
                    tmp += c;

                }

                lst.Add(tmp);
                string[] result = lst.ToArray();
                return result;
            }
            public bool Compare2Value(string condition)
            {
                bool result = false;
                string[] a = condition.Split(new string[] { ">", "<", "=", ">=", "<=" }, StringSplitOptions.None);
                Calculate value = new Calculate();
                if (condition.Contains(">"))
                {
                    result = value.CALCULATE(a[0].Split(' '), ID_NhanVien, date) > value.CALCULATE(a[1].Split(' '), ID_NhanVien, date) ? true : false;
                }
                else if (condition.Contains("<"))
                {
                    result = value.CALCULATE(a[0].Split(' '), ID_NhanVien, date) < value.CALCULATE(a[1].Split(' '), ID_NhanVien, date) ? true : false;
                }
                else if (condition.Contains("="))
                {
                    result = value.CALCULATE(a[0].Split(' '), ID_NhanVien, date) == value.CALCULATE(a[1].Split(' '), ID_NhanVien, date) ? true : false;
                }
                else if (condition.Contains(">="))
                {
                    result = value.CALCULATE(a[0].Split(' '), ID_NhanVien, date) >= value.CALCULATE(a[1].Split(' '), ID_NhanVien, date) ? true : false;
                }
                else if (condition.Contains("<="))
                {
                    result = value.CALCULATE(a[0].Split(' '), ID_NhanVien, date) <= value.CALCULATE(a[1].Split(' '), ID_NhanVien, date) ? true : false;
                }

                return result;
            }
            public string convertStringFormula(string[] lstStringFormula)
            {
                string result = "";
                for (int i = 0; i < lstStringFormula.Length; i++)
                {
                    string str = lstStringFormula[i];
                    if (lstStringFormula[i].Contains("PC_"))
                    {
                        string[] parseElement = lstStringFormula[i].Split('_');
                        lstStringFormula[i] = ReplaceValue(lstStringFormula[i],
                                                            "PC_" + "\\d+",
                                                            data.spGetBenefit(ID_NhanVien, Int32.Parse(parseElement[1])).FirstOrDefault().Value.ToString("0.000"));
                    }
                    else if (lstStringFormula[i].Contains("BH_TH_"))
                    {

                        string[] parseElement = lstStringFormula[i].Split('_');
                        lstStringFormula[i] = ReplaceValue(lstStringFormula[i],
                                                            "BH_TH_" + "\\d+",
                                                            data.BAOHIEM_THUE.Find(Int32.Parse(parseElement[2].
                                                                                                Replace(")", "").
                                                                                                Replace("(", "").
                                                                                                Replace(",", ""))).PhanTramBaoHiem.ToString());
                    }
                    else if (lstStringFormula[i].Contains("NV_"))
                    {
                        string[] parseElement = lstStringFormula[i].Split('_');
                        switch (parseElement[1])
                        {
                            case "Km":
                                {
                                    lstStringFormula[i] = lstStringFormula[i].Replace("NV_Km", data.NHANSUs.Find(this.ID_NhanVien).Km.HasValue ? data.NHANSUs.Find(this.ID_NhanVien).Km.Value.ToString() : "0");
                                    break;
                                }
                            case "LuongCB":
                                {
                                    lstStringFormula[i] = lstStringFormula[i].Replace("NV_LuongCB", data.NHANSUs.Find(this.ID_NhanVien).LuongCB.HasValue ? data.NHANSUs.Find(this.ID_NhanVien).LuongCB.Value.ToString() : "0");
                                    break;
                                }
                            case "PayBack":
                                {
                                    lstStringFormula[i] = lstStringFormula[i].Replace("NV_PayBack", data.NHANSUs.Find(this.ID_NhanVien).PayBack.HasValue ? data.NHANSUs.Find(this.ID_NhanVien).LuongCB.Value.ToString() : "0");
                                    break;
                                }
                            case "NguoiPhuThuoc":
                                {
                                    lstStringFormula[i] = lstStringFormula[i].Replace("NV_NguoiPhuThuoc", data.NHANSUs.Find(this.ID_NhanVien).SoNguoiPhuThuoc.HasValue ? data.NHANSUs.Find(this.ID_NhanVien).SoNguoiPhuThuoc.Value.ToString() : "0");
                                    break;
                                }
                            default:
                                {
                                    lstStringFormula[i] = "0";
                                    break;
                                }
                        }
                    }
                    else if (lstStringFormula[i].Contains("OTH_"))
                    {

                        string[] parseElement = lstStringFormula[i].Split('_');
                        if (parseElement.Length < 0)
                            return lstStringFormula[i];
                        string[] resultFromFormulaPayrall = data.FORMULA_OF_PAYROLL.Find(Int32.Parse(parseElement[1]
                                                                                                        .Replace("(", "")
                                                                                                        .Replace(")", "")
                                                                                                        .Replace(",", "")
                                                                                                        )).Formula.Split(' ');
                        Calculate val = new Calculate();
                        lstStringFormula[i] = ReplaceValue(lstStringFormula[i],
                                                            "OTH_" + "\\d+",
                                                            val.CALCULATE(convertStringFormula(resultFromFormulaPayrall).Split(' '), ID_NhanVien, date).ToString());
                    }
                    else if (lstStringFormula[i].Contains("OT_"))
                    {
                        lstStringFormula[i] = "1";
                    }
                    else if (lstStringFormula[i].Contains("WorkingDays"))
                    {
                        lstStringFormula[i] = Weekdays(new DateTime(date.Year, date.Month, 1), new DateTime(date.Year, date.Month, 1).AddMonths(1).AddDays(-1)).ToString();
                    }
                    else if (lstStringFormula[i].Contains("AtWorks"))
                    {
                        int weekdays = Weekdays(new DateTime(date.Year, date.Month, 1), new DateTime(date.Year, date.Month, 1).AddMonths(1).AddDays(-1));
                        int OFFDays = CalculateTotalOFFDayInWeekdays(ID_NhanVien,
                                                                    new DateTime(date.Year, date.Month, 1),
                                                                    new DateTime(date.Year, date.Month, 1).AddMonths(1).AddDays(-1));
                        string nameStaff = data.NHANSUs.Find(ID_NhanVien).HoVaTen;
                        fnDisplayWorkingDaysStaffOfMonth_Result WorkingHoursStaff = data.fnDisplayWorkingDaysStaffOfMonth(nameStaff, date).FirstOrDefault();
                        int WFHDays = WorkingHoursStaff.WFH.HasValue ? WorkingHoursStaff.WFH.Value : 0;
                        lstStringFormula[i] = (weekdays - OFFDays - WFHDays).ToString();
                    }
                    else if (lstStringFormula[i].Contains("WFHDays"))
                    {
                        string nameStaff = data.NHANSUs.Find(ID_NhanVien).HoVaTen;
                        fnDisplayWorkingDaysStaffOfMonth_Result WorkingHoursStaff = data.fnDisplayWorkingDaysStaffOfMonth(nameStaff, date).FirstOrDefault();
                        lstStringFormula[i] = WorkingHoursStaff.WFH.HasValue ? WorkingHoursStaff.WFH.Value.ToString() : "0";
                    }
                    else if (lstStringFormula[i].Contains("LeaveHours"))
                    {
                        string nameStaff = data.NHANSUs.Find(ID_NhanVien).HoVaTen;
                        fnDisplayWorkingDaysStaffOfMonth_Result WorkingHoursStaff = data.fnDisplayWorkingDaysStaffOfMonth(nameStaff, date).FirstOrDefault();
                        lstStringFormula[i] = WorkingHoursStaff.LEAVES.HasValue ? WorkingHoursStaff.LEAVES.Value.ToString() : "0";
                    }
                    else if (lstStringFormula[i].Contains("OFFDays"))
                    {
                        lstStringFormula[i] = CalculateTotalOFFDayInWeekdays(ID_NhanVien,
                                                                    new DateTime(date.Year, date.Month, 1),
                                                                    new DateTime(date.Year, date.Month, 1).AddMonths(1).AddDays(-1)).ToString();
                    }
                }
                foreach (string element in lstStringFormula)
                {
                    result += element;
                }
                return result;
            }
            public string ReplaceValue(string str1, string pattern, string str2)
            {
                string result;
                Regex rgx = new Regex(pattern);
                result = rgx.Replace(str1, str2);
                return " " + result + " ";
            }
            private int Weekdays(DateTime dtmStart, DateTime dtmEnd)
            {
                // This function includes the start and end date in the count if they fall on a weekday
                int dowStart = ((int)dtmStart.DayOfWeek == 0 ? 7 : (int)dtmStart.DayOfWeek);
                int dowEnd = ((int)dtmEnd.DayOfWeek == 0 ? 7 : (int)dtmEnd.DayOfWeek);
                TimeSpan tSpan = dtmEnd - dtmStart;
                if (dowStart <= dowEnd)
                {
                    return (((tSpan.Days / 7) * 5) + Math.Max((Math.Min((dowEnd + 1), 6) - dowStart), 0));
                }
                return (((tSpan.Days / 7) * 5) + Math.Min((dowEnd + 6) - Math.Min(dowStart, 6), 5));
            }
            private int CalculateTotalOFFDayInWeekdays(int ID, DateTime start, DateTime end)
            {
                int result = 0;
                List<fnDisplayOFFDayFollowCondition_Result> tmp = data.fnDisplayOFFDayFollowCondition(start, end, data.NHANSUs.Find(ID).HoVaTen).ToList();
                foreach (var item in tmp)
                {
                    if (item.ID_LoaiNgayNghi != 1 && item.ID_LoaiNgayNghi != 2)
                    {
                        DateTime startDay = (item.NgayBatDau.Value < start ? start : item.NgayBatDau.Value);
                        DateTime endDay = (item.NgayKetThuc.Value > end ? end : item.NgayKetThuc.Value);
                        result = result + Weekdays(startDay, endDay);
                    }
                }
                return result;
            }
            static public string[] ParseStringCondition(string s)
            {
                string[] a = s.Split(',');
                a[0] = a[0].Replace("IF(", "");
                if (a.Length > 3)
                {
                    for (int i = 3; i < a.Length; i++)
                    {
                        a[2] = a[2] + " , " + a[i];
                    }
                }
                a[2] = a[2].Remove(a[2].Length - 1);
                string[] result = new string[7];
                result[0] = "IF(";
                result[1] = a[0];
                result[2] = ",";
                result[3] = a[1];
                result[4] = ",";
                result[5] = a[2];
                result[6] = ")";

                return result;

            }

        }
    }
}
