module ApplicationHelper
  
  def month_th
    ['','มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน ','ตุลาคม','พฤศจิกายน','ธันวาคม']    
  end
  def to_datetime_th dt
         dt_r = "วันที่ "+dt.day.to_s + " เดือน " + month_th[dt.month] + " พ.ศ " + (dt.year + 543).to_s + " " + dt.hour.to_s + ":" + dt.min.to_s
         dt_r
  end
  
  def to_date_th dt
         dt_r = "วันที่ "+dt.day.to_s + " เดือน " + month_th[dt.month] + " พ.ศ " + (dt.year + 543).to_s
         dt_r
  end
  
  def to_date_th_short dt
         dt_r = dt.day.to_s + "/" + dt.month.to_s + " /" + (dt.year + 543).to_s
         dt_r
  end  
  
  def status st
    s = ""
    if st.to_s == "0"
      s= "ไม่ใช้งาน"
    elsif st.to_s == "1"
      s="ใช้งาน"
    else
      s=""
    end
  end
  
  def claim st
    s = ""
    if st.to_s == "0"
      s= "เบิกไม่ได้"
    elsif st.to_s == "1"
      s="เบิกได้"
    else
      s=""
    end
    s
  end
  
  def status_admin s
    if s.to_s == "1"
      "ใช่"
    elsif s.to_s == '0'
      "ไม่ใช่"
    end
  end
  
end
