<?xml version="1.0" encoding="UTF-8"?>
<sqlMap namespace="emr">
    <database id="emr" description="" >
        <![CDATA[
            <?xml version="1.0" encoding="UTF-8"?>
            <sqlMap namespace="emr">
                <!-- ============================================================ -->
                <!-- 电子病历表 - emr                                              -->
                <!-- ============================================================ -->
                <database id="list" description="查询电子病历列表（分页）">
                    <![CDATA[
                        SELECT e.id, e.patient_id, e.visit_id, e.prescription_id, e.visit_date, e.chief_complaint, e.present_illness, e.past_history, e.tongue_image, e.pulse_image, e.complexion, e.voice, e.syndrome, e.diagnosis, e.treatment_principle, e.prescription_text, e.notes, e.treatment_result, e.follow_up, e.doctor_id, e.status, e.created_at, e.updated_at,
                               p.name AS patient_name, u.real_name AS doctor_name
                        FROM emr e
                        LEFT JOIN patient p ON e.patient_id = p.id
                        LEFT JOIN sys_user u ON e.doctor_id = u.id
                        WHERE 1=1
                        <if test="patientId != null">
                            AND e.patient_id = #{patientId}
                        </if>
                        <if test="doctorId != null">
                            AND e.doctor_id = #{doctorId}
                        </if>
                        <if test="status != null and status != ''">
                            AND e.status = #{status}
                        </if>
                        <if test="visitDateStart != null">
                            AND e.visit_date >= #{visitDateStart}
                        </if>
                        <if test="visitDateEnd != null">
                            AND e.visit_date <= #{visitDateEnd}
                        </if>
                        ORDER BY e.visit_date DESC
                        LIMIT #{offset}, #{pageSize}
                    ]]>
                </database>
                <database id="count" description="查询电子病历总数">
                    <![CDATA[
                        SELECT COUNT(*)
                        FROM emr e
                        WHERE 1=1
                        <if test="patientId != null">
                            AND e.patient_id = #{patientId}
                        </if>
                        <if test="doctorId != null">
                            AND e.doctor_id = #{doctorId}
                        </if>
                        <if test="status != null and status != ''">
                            AND e.status = #{status}
                        </if>
                    ]]>
                </database>
                <database id="detail" description="根据ID查询电子病历详情">
                    <![CDATA[
                        SELECT e.id, e.patient_id, e.visit_id, e.prescription_id, e.visit_date, e.chief_complaint, e.present_illness, e.past_history, e.tongue_image, e.pulse_image, e.complexion, e.voice, e.syndrome, e.diagnosis, e.treatment_principle, e.prescription_text, e.notes, e.treatment_result, e.follow_up, e.doctor_id, e.status, e.created_at, e.updated_at,
                               p.name AS patient_name, u.real_name AS doctor_name
                        FROM emr e
                        LEFT JOIN patient p ON e.patient_id = p.id
                        LEFT JOIN sys_user u ON e.doctor_id = u.id
                        WHERE e.id = #{id}
                    ]]>
                </database>
                <database id="insert" description="新增电子病历">
                    <![CDATA[
                        INSERT INTO emr (patient_id, visit_id, prescription_id, visit_date, chief_complaint, present_illness, past_history, tongue_image, pulse_image, complexion, voice, syndrome, diagnosis, treatment_principle, prescription_text, notes, treatment_result, follow_up, doctor_id, status)
                        VALUES (#{patientId}, #{visitId}, #{prescriptionId}, #{visitDate}, #{chiefComplaint}, #{presentIllness}, #{pastHistory}, #{tongueImage}, #{pulseImage}, #{complexion}, #{voice}, #{syndrome}, #{diagnosis}, #{treatmentPrinciple}, #{prescriptionText}, #{notes}, #{treatmentResult}, #{followUp}, #{doctorId}, #{status})
                    ]]>
                </database>
                <database id="update" description="修改电子病历">
                    <![CDATA[
                        UPDATE emr
                        SET visit_id = #{visitId},
                            prescription_id = #{prescriptionId},
                            chief_complaint = #{chiefComplaint},
                            present_illness = #{presentIllness},
                            past_history = #{pastHistory},
                            tongue_image = #{tongueImage},
                            pulse_image = #{pulseImage},
                            complexion = #{complexion},
                            voice = #{voice},
                            syndrome = #{syndrome},
                            diagnosis = #{diagnosis},
                            treatment_principle = #{treatmentPrinciple},
                            prescription_text = #{prescriptionText},
                            notes = #{notes},
                            treatment_result = #{treatmentResult},
                            follow_up = #{followUp},
                            status = #{status}
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="delete" description="删除电子病历">
                    <![CDATA[
                        DELETE FROM emr WHERE id = #{id}
                    ]]>
                </database>
            </sqlMap>
            
        ]]>
    </database>
</sqlMap>