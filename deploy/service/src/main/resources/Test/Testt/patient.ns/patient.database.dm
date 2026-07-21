<?xml version="1.0" encoding="UTF-8"?>
<sqlMap namespace="patient">
    <database id="patient" description="" >
        <![CDATA[
            <?xml version="1.0" encoding="UTF-8"?>
            <sqlMap namespace="patient">
                <!-- ============================================================ -->
                <!-- 系统用户表 - sys_user                                        -->
                <!-- ============================================================ -->
                <database id="userList" description="查询用户列表（分页）">
                    <![CDATA[
                        SELECT id, username, role, real_name, phone, is_active, created_at, updated_at
                        FROM sys_user
                        WHERE 1=1
                        <if test="username != null and username != ''">
                            AND username LIKE CONCAT('%', #{username}, '%')
                        </if>
                        <if test="role != null and role != ''">
                            AND role = #{role}
                        </if>
                        <if test="isActive != null">
                            AND is_active = #{isActive}
                        </if>
                        ORDER BY created_at DESC
                        LIMIT #{offset}, #{pageSize}
                    ]]>
                </database>
                <database id="userCount" description="查询用户总数">
                    <![CDATA[
                        SELECT COUNT(*)
                        FROM sys_user
                        WHERE 1=1
                        <if test="username != null and username != ''">
                            AND username LIKE CONCAT('%', #{username}, '%')
                        </if>
                        <if test="role != null and role != ''">
                            AND role = #{role}
                        </if>
                        <if test="isActive != null">
                            AND is_active = #{isActive}
                        </if>
                    ]]>
                </database>
                <database id="userDetail" description="根据ID查询用户详情">
                    <![CDATA[
                        SELECT id, username, role, real_name, phone, is_active, created_at, updated_at
                        FROM sys_user
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="userByUsername" description="根据用户名查询用户">
                    <![CDATA[
                        SELECT id, username, password_hash, role, real_name, phone, is_active, created_at, updated_at
                        FROM sys_user
                        WHERE username = #{username}
                    ]]>
                </database>
                <database id="userInsert" description="新增用户">
                    <![CDATA[
                        INSERT INTO sys_user (username, password_hash, role, real_name, phone, is_active)
                        VALUES (#{username}, #{passwordHash}, #{role}, #{realName}, #{phone}, #{isActive})
                    ]]>
                </database>
                <database id="userUpdate" description="修改用户信息">
                    <![CDATA[
                        UPDATE sys_user
                        SET username = #{username},
                            role = #{role},
                            real_name = #{realName},
                            phone = #{phone},
                            is_active = #{isActive}
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="userUpdatePassword" description="修改用户密码">
                    <![CDATA[
                        UPDATE sys_user
                        SET password_hash = #{passwordHash}
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="userDelete" description="删除用户">
                    <![CDATA[
                        DELETE FROM sys_user WHERE id = #{id}
                    ]]>
                </database>
            
                <!-- ============================================================ -->
                <!-- 患者信息表 - patient                                          -->
                <!-- ============================================================ -->
                <database id="list" description="查询患者列表（分页）">
                    <![CDATA[
                        SELECT id, name, gender, age, phone, id_card, address, blood_type, height, weight, allergy_info, status, created_at, updated_at
                        FROM patient
                        WHERE 1=1
                        <if test="name != null and name != ''">
                            AND name LIKE CONCAT('%', #{name}, '%')
                        </if>
                        <if test="phone != null and phone != ''">
                            AND phone = #{phone}
                        </if>
                        <if test="status != null and status != ''">
                            AND status = #{status}
                        </if>
                        ORDER BY created_at DESC
                        LIMIT #{offset}, #{pageSize}
                    ]]>
                </database>
                <database id="count" description="查询患者总数">
                    <![CDATA[
                        SELECT COUNT(*)
                        FROM patient
                        WHERE 1=1
                        <if test="name != null and name != ''">
                            AND name LIKE CONCAT('%', #{name}, '%')
                        </if>
                        <if test="phone != null and phone != ''">
                            AND phone = #{phone}
                        </if>
                        <if test="status != null and status != ''">
                            AND status = #{status}
                        </if>
                    ]]>
                </database>
                <database id="detail" description="根据ID查询患者详情">
                    <![CDATA[
                        SELECT id, name, gender, age, phone, id_card, address, blood_type, height, weight, allergy_info, status, created_by, created_at, updated_at
                        FROM patient
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="insert" description="新增患者">
                    <![CDATA[
                        INSERT INTO patient (name, gender, age, phone, id_card, address, blood_type, height, weight, allergy_info, status, created_by)
                        VALUES (#{name}, #{gender}, #{age}, #{phone}, #{idCard}, #{address}, #{bloodType}, #{height}, #{weight}, #{allergyInfo}, #{status}, #{createdBy})
                    ]]>
                </database>
                <database id="update" description="修改患者信息">
                    <![CDATA[
                        UPDATE patient
                        SET name = #{name},
                            gender = #{gender},
                            age = #{age},
                            phone = #{phone},
                            id_card = #{idCard},
                            address = #{address},
                            blood_type = #{bloodType},
                            height = #{height},
                            weight = #{weight},
                            allergy_info = #{allergyInfo},
                            status = #{status}
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="delete" description="删除患者">
                    <![CDATA[
                        DELETE FROM patient WHERE id = #{id}
                    ]]>
                </database>
            
                <!-- ============================================================ -->
                <!-- 就诊记录表 - visit_record                                     -->
                <!-- ============================================================ -->
                <database id="visitList" description="查询就诊记录列表（分页）">
                    <![CDATA[
                        SELECT vr.id, vr.patient_id, vr.doctor_id, vr.visit_date, vr.chief_complaint, vr.present_illness, vr.past_history, vr.allergy_history, vr.personal_history, vr.tongue_image, vr.pulse_image, vr.other_exams, vr.status, vr.created_at, vr.updated_at,
                               p.name AS patient_name, u.real_name AS doctor_name
                        FROM visit_record vr
                        LEFT JOIN patient p ON vr.patient_id = p.id
                        LEFT JOIN sys_user u ON vr.doctor_id = u.id
                        WHERE 1=1
                        <if test="patientId != null">
                            AND vr.patient_id = #{patientId}
                        </if>
                        <if test="doctorId != null">
                            AND vr.doctor_id = #{doctorId}
                        </if>
                        <if test="status != null and status != ''">
                            AND vr.status = #{status}
                        </if>
                        <if test="visitDateStart != null">
                            AND vr.visit_date >= #{visitDateStart}
                        </if>
                        <if test="visitDateEnd != null">
                            AND vr.visit_date <= #{visitDateEnd}
                        </if>
                        ORDER BY vr.visit_date DESC
                        LIMIT #{offset}, #{pageSize}
                    ]]>
                </database>
                <database id="visitCount" description="查询就诊记录总数">
                    <![CDATA[
                        SELECT COUNT(*)
                        FROM visit_record vr
                        WHERE 1=1
                        <if test="patientId != null">
                            AND vr.patient_id = #{patientId}
                        </if>
                        <if test="doctorId != null">
                            AND vr.doctor_id = #{doctorId}
                        </if>
                        <if test="status != null and status != ''">
                            AND vr.status = #{status}
                        </if>
                    ]]>
                </database>
                <database id="visitDetail" description="根据ID查询就诊记录详情">
                    <![CDATA[
                        SELECT vr.id, vr.patient_id, vr.doctor_id, vr.visit_date, vr.chief_complaint, vr.present_illness, vr.past_history, vr.allergy_history, vr.personal_history, vr.tongue_image, vr.pulse_image, vr.other_exams, vr.status, vr.created_at, vr.updated_at,
                               p.name AS patient_name, u.real_name AS doctor_name
                        FROM visit_record vr
                        LEFT JOIN patient p ON vr.patient_id = p.id
                        LEFT JOIN sys_user u ON vr.doctor_id = u.id
                        WHERE vr.id = #{id}
                    ]]>
                </database>
                <database id="visitInsert" description="新增就诊记录">
                    <![CDATA[
                        INSERT INTO visit_record (patient_id, doctor_id, visit_date, chief_complaint, present_illness, past_history, allergy_history, personal_history, tongue_image, pulse_image, other_exams, status)
                        VALUES (#{patientId}, #{doctorId}, #{visitDate}, #{chiefComplaint}, #{presentIllness}, #{pastHistory}, #{allergyHistory}, #{personalHistory}, #{tongueImage}, #{pulseImage}, #{otherExams}, #{status})
                    ]]>
                </database>
                <database id="visitUpdate" description="修改就诊记录">
                    <![CDATA[
                        UPDATE visit_record
                        SET chief_complaint = #{chiefComplaint},
                            present_illness = #{presentIllness},
                            past_history = #{pastHistory},
                            allergy_history = #{allergyHistory},
                            personal_history = #{personalHistory},
                            tongue_image = #{tongueImage},
                            pulse_image = #{pulseImage},
                            other_exams = #{otherExams},
                            status = #{status}
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="visitDelete" description="删除就诊记录">
                    <![CDATA[
                        DELETE FROM visit_record WHERE id = #{id}
                    ]]>
                </database>
            </sqlMap>
            
        ]]>
    </database>
</sqlMap>