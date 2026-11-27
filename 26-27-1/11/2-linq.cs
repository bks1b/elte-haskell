List<string> GetStudentsImperative(List<Student> students) {
    // filter
    var passed = new List<Student>();
    foreach (var student in students)
        if (student.Grade > 1)
            passed.Add(student);
    // sortBy
    passed.Sort((a, b) => b.Grade.CompareTo(a.Grade));
    // take, map
    var result = new List<string>();
    for (int i = 0; i < 3 && i < passed.Count; i++)
        result.Add(passed[i].Name);
    return result;
}

List<string> GetStudentsFunctional(List<Student> students) => students
    .Where(x => x.Grade > 1)         // filter
    .OrderByDescending(x => x.Grade) // sortBy
    .Take(3)                         // take
    .Select(x => x.Name)             // map
    .ToList(); // lusta kiértékelés miatt

record Student(string Name, int Grade);
